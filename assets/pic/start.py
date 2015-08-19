#!/usr/bin/env python
# encoding: utf-8
import os
import sys
import Image
#from __future__ import with_statement

import xlrd
import shutil

sys.path.append("../")
from script.util import _int
from script.util import _utf8
from script.util import _j2f
from script.util import multilanguagefd
from script.util import multilanguage
from script.util import converter_0
from script.util import gen_file
from script.util import gen_adminserver_file

IMAGE_FLAG_NORMAL = 0
IMAGE_FLAG_JSON = 1
IMAGE_FLAG_MAP = 2
IMAGE_FLAG_CSB = 3
IMAGE_FLAG_EQUIP = 4

def converter_plist(excel_file, sheet_name, argv_type, argv_lang ):
    book = xlrd.open_workbook(excel_file)
    sheet = book.sheet_by_name(sheet_name)
    print sheet.name
        
    rows_dict = {}
    
    for i in xrange(1, sheet.nrows):
        # 循环sheet中的行
        if argv_type.lower() == 'ios' and argv_lang.lower() != 'multi':
            row_key = _utf8(sheet.cell_value(i, 0))
        elif argv_type.lower() == 'android' and argv_lang.lower() != 'multi':
            row_key = _utf8(sheet.cell_value(i, 1))
        elif argv_type.lower() == 'wp8' and argv_lang.lower() != 'multi':
            row_key = _utf8(sheet.cell_value(i, 2))
        elif argv_type.lower() == 'ios' and argv_lang.lower() == 'multi':
            row_key = _utf8(sheet.cell_value(i, 3))
        elif argv_type.lower() == 'android' and argv_lang.lower() == 'multi':
            row_key = _utf8(sheet.cell_value(i, 4))
        elif argv_type.lower() == 'wp8'  and argv_lang.lower() == 'multi':
            row_key = _utf8(sheet.cell_value(i, 5))
        else:
            row_key = _utf8(sheet.cell_value(i, 0))

        row_flag = _int(sheet.cell_value(i, 6))
        row_value = _utf8(sheet.cell_value(i, 7))

        if argv_type.lower() == 'ios':
            row_format = _utf8(sheet.cell_value(i, 8))
        elif argv_type.lower() == 'android':
            row_format = _utf8(sheet.cell_value(i, 9))
        elif argv_type.lower() == 'wp8':
            row_format = _utf8(sheet.cell_value(i, 10))
        else:
            row_format = _utf8(sheet.cell_value(i, 8))

        
        #文件
        if row_flag == 1:
            if row_value.find('.png') >= 0:
                if rows_dict.has_key(row_key):
                    rows_dict[row_key].append([row_flag,row_value,row_format])
                else:
                    rows_dict[row_key] = [[row_flag,row_value,row_format]]
        #目录
        elif row_flag == 2 or row_flag == 4:
            for file_name in os.listdir(row_value):
                if os.path.isdir(row_value + os.path.sep + file_name):
                    continue

                if file_name.find('.png') >= 0:
                    if rows_dict.has_key(row_key):
                        rows_dict[row_key].append([row_flag,row_value + os.path.sep + file_name,row_format])
                    else:
                        rows_dict[row_key] = [[row_flag,row_value + os.path.sep + file_name,row_format]]
        #忽略
        elif row_flag == 3:
            if rows_dict.has_key(row_key):
                delete_index = -1
                for i in xrange(0,len(rows_dict[row_key])):
                    if rows_dict[row_key][i][1] == row_value:
                        delete_index = i
                        break
                if delete_index != -1:
                    del rows_dict[row_key][delete_index]
        else:
            pass
   

    return rows_dict 



def walkpath(path_name,path_dict):
    
    for file_name in os.listdir(path_name):        
        sub_path = os.path.join(path_name, file_name)
                          
        if os.path.isdir(sub_path):
            if file_name == ".svn":
                continue
            else:
                walkpath(sub_path,path_dict)
        else:
            if path_dict.has_key(path_name):
                path_dict[path_name].append(sub_path)
            else:
                path_dict[path_name] = [sub_path]
                

def ignoreFile(src, names):
    return ['.svn','xcopy.bat', 'pack.exe', 'size.bat', 'copyfile.bat']

def getFormatFlag(argv_type,argv_format):
    temp_type = argv_type + '-'
                    
    if argv_type.lower() == 'ios':
        temp_type = temp_type + argv_format
    elif argv_type.lower() == 'android':
        temp_type = temp_type + argv_format
    elif argv_type.lower() == 'wp8':
        temp_type = temp_type + argv_format
    else:
        raise    
    
    return temp_type

def safeRmTree(pathName):
    if os.path.exists(pathName):
        shutil.rmtree(pathName)

def safeCopy(fileName,pathName):
    realPathName = os.path.dirname(pathName)
    if not os.path.exists(realPathName):
        os.makedirs(realPathName)
    shutil.copy(fileName,pathName)

def safeWrite(fileName,content):
    pathName = os.path.dirname(fileName)
    if not os.path.exists(pathName):
        os.makedirs(pathName)

    with open(fileName, 'w') as fw:
        fw.write(content)

def getDiffList(argv_start,argv_end,argv_line):
    temp_list = list()
    cmd_text = 'svn diff --summarize -r %d:%d "svn://192.168.2.6/super2_conf/%s/src/pic/res" > diff.txt'%(argv_start,argv_end,argv_line)
    if argv_end == 0:
        cmd_text = 'svn diff --summarize -r %d "svn://192.168.2.6/super2_conf/%s/src/pic/res" > diff.txt'%(argv_start,argv_line)

    os.system(cmd_text)
    with open('diff.txt', 'r') as fr:
        line = fr.readline()
        while line:
            nPos = line.find('/res/')
            if nPos != -1:
                temp_list.append(line[nPos+1:].replace('\n',''))
            line = fr.readline()

    return temp_list

def getImageFlag(img_name):
    temp_flag = IMAGE_FLAG_NORMAL
    
    if img_name.find('\\json\\') >= 0:
        temp_flag = IMAGE_FLAG_JSON

    if img_name.find('res\\map\\') >= 0:
        temp_flag = IMAGE_FLAG_MAP
    
    if img_name.find('\\csb\\') >= 0:
        temp_flag = IMAGE_FLAG_CSB

    return temp_flag

def getPublicresFlag(img_name,publicres_dict,argv_platform):
    if img_name.find('.png') < 0:
        return False,img_name

    continue_flag = False
    target_name = img_name

    for publicres_key in publicres_dict.iterkeys():
        if img_name.find(publicres_key+'_') >= 0 or img_name == publicres_key+'.png':
            continue_flag = True
            if img_name == publicres_key+'_'+argv_platform+'.png':
                continue_flag = False
                target_name = publicres_key+'.png'
                break                    
                
    return continue_flag,target_name

def getLanguageresFlag(img_name,languageres_dict,argv_lang):
    if img_name.find('.png') < 0:
        return False,img_name

    continue_flag = False
    target_name = img_name
    if argv_lang == 'gbk':
        for languageres_key in languageres_dict.iterkeys():
            if img_name.find(languageres_key+'-') >= 0:
                return True,""
    else:
        for languageres_key in languageres_dict.iterkeys():
            if img_name.find(languageres_key+'-') >= 0 or img_name == languageres_key+'.png':
                continue_flag = True
                if argv_lang == 'multi':
                    continue_flag = False
                    break
                if img_name == languageres_key+'-'+argv_lang+'.png':
                    continue_flag = False
                    target_name = languageres_key+'.png'
                    break
        return continue_flag,target_name
    return False,img_name


def getPlistedFlag(img_name,plist_dict,argv_type):
    if img_name.find('.png') < 0:
        return False

    #查找是否已经被plist,win32不做plist
    if argv_type != 'win32':
        for plist_key,plist_value in plist_dict.iteritems():
            #处理图片
            for k in xrange(0,len(plist_value)):
                plist_name = plist_value[k][1]
                                            
                if img_name.lower() == plist_name.lower():
                    return True
    return False                    

def getPlistExistedFlag(img_name,path_dict,row_key):
    if img_name.find('.png') < 0:
        return False

    img_plist = os.path.splitext(img_name)[0]+'.plist'
    for k in xrange(0,len(path_dict[row_key])):
        if path_dict[row_key][k] == img_plist:
            return True
    return False


def getImageType(img_name,argv_type):
    type_format = ""
    if not os.path.exists(img_name):
        print img_name,"not exists!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    else:
        img_flag = getImageFlag(img_name)
        if img_name.find('.png') >= 0:
            img = Image.open(img_name)
            if img:
                if img.mode == 'RGBA':
                    if img_flag == IMAGE_FLAG_JSON:
                        type_format = 'selfmiddle'
                    elif argv_type.lower() == 'ios':
                        type_format = 'pvrtc4'
                    elif argv_type.lower() == 'android':
                        type_format = 'rgba4444'
                    elif argv_type.lower() == 'wp8':
                        type_format = 'rgba4444'
                    else:
                        type_format = 'rgba8888'
                elif img.mode == 'RGB':
                    if argv_type.lower() == 'ios':
                        type_format = 'pvrtc4'
                    elif argv_type.lower() == 'android':
                        type_format = 'rgb565'
                    elif argv_type.lower() == 'wp8':
                        type_format = 'rgb565'
                    else:
                        type_format = 'rgb888'
                else:
                    if argv_type.lower() == 'ios':
                        type_format = 'pvrtc4'
                    elif argv_type.lower() == 'android':
                        type_format = 'none'
                    elif argv_type.lower() == 'wp8':
                        type_format = 'none'
                    else:
                        type_format = 'none'

            else:
                print img_name+'==open error!'
                raise
    return type_format  

def convertImg(argv_type,argv_line,argv_platform,argv_lang,argv_start,argv_end):
    """
    """

    diff_flag = False
    if argv_start != -1 and argv_end != -1:
        diff_flag = True

    diff_list = list()
    if diff_flag:
        diff_list = getDiffList(argv_start,argv_end,argv_line)

    print diff_list
    
    excel_file = 'plist.xls'  # excel配置文件，xls格式
    client_template = 'resDB.lua'  # 后端配置文件模版
    client_output = 'resDB.lua'  #  后端配置输出文件
    plist_dict = converter_plist(excel_file,"plist",argv_type,argv_lang)

    #公共资源列表
    book = xlrd.open_workbook('plist.xls')
    sheet = book.sheet_by_name('platform')
    print sheet.name
    publicres_dict = {}
    for i in xrange(1, sheet.nrows):
        # 循环sheet中的行
        row_key = _utf8(sheet.cell_value(i, 0))
        publicres_dict[row_key] = ""
    
    #多语言资源列表
    book = xlrd.open_workbook('plist.xls')
    sheet = book.sheet_by_name('language')
    print sheet.name
    languageres_dict = {}
    for i in xrange(1, sheet.nrows):
        # 循环sheet中的行
        row_key = _utf8(sheet.cell_value(i, 0))
        languageres_dict[row_key] = ""


    #生成resDB
    row_texts = ""
    
    #win32不做plist
    need_raise = False
    if argv_type != 'win32':
        for row_key,row_value in plist_dict.iteritems():
            #处理图片
            for j in xrange(0,len(row_value)):
                #拆分目录
                img_flag = row_value[j][0]
                img_name = row_value[j][1]

                img_flag = getImageFlag(img_name)

                if img_flag == IMAGE_FLAG_MAP or img_flag == IMAGE_FLAG_JSON or img_flg == IMAGE_FLAG_CSB:
                    continue

                #查找是否多平台文件
                continue_flag,target_name = getPublicresFlag(img_name,publicres_dict,argv_platform)

                if continue_flag:
                    continue
                else:
                    img_name = target_name

                #查找是否多语言文件
                continue_flag,target_name = getLanguageresFlag(img_name,languageres_dict,argv_lang)

                if continue_flag:
                    continue
                else:
                    img_name = target_name


                img_path = os.path.splitext(img_name)[0]            
                
                if img_flag == 4:
                    img_path = os.path.splitext(os.path.basename(img_name))[0]
                    
                img_plist = row_key.replace('\\','/')
     
                img_path = img_path.replace('\\','#')

                type_format = row_value[j][2]

                #检查plist配置的图像转换是否正确
                if argv_type.lower() in ['android','wp8']:
                    if not os.path.exists(img_name):
                        print img_name,"not exists!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                    else:
                        img = Image.open(img_name)
                        if img:
                            if img.mode == 'RGBA':
                                in_list = ['rgba8888','rgba4444','rgba5551','pvrtc4','dxt3','selflow','selfhigh','selfmiddle']
                            elif img.mode == 'RGB':
                                in_list = ['rgb888','rgb565','pvrtc4_noalpha','dxt1']
                            else:
                                in_list = ['none']
                            need_raise = True
                            for data in in_list:
                                if data in type_format:
                                    need_raise = False
                            if need_raise:
                                    print img_name+" convert format error! need "+str(in_list)
                        else:
                            print img_name+'==open error!'
                            raise
                
                if need_raise:
                    raise

                if row_key.lower() != 'none':                
                    row_texts = row_texts + '\t["%s"]={"%s",%d,"%s"},\n'%(img_path,img_plist+'.plist',1,type_format)
                else:
                    type_flag = 0
                    type_img_name = os.path.splitext(img_name.replace('\\','/'))[0]
                    type_img_ext = os.path.splitext(img_name.replace('\\','/'))[1]
                    if type_img_ext.lower() != '.png':
                        type_img_name = img_name.replace('\\','/')
                    else:
                        if argv_type.lower() in ['ios','android','wp8']:
                            if type_format == 'none':
                                type_img_name = img_name.replace('\\','/')
                                type_flag = 0
                            else:
                                type_img_name = type_img_name + '.plist'
                                type_flag = 1
                        else:
                            raise
             
                    if img_name.find('\\ui\\') >= 0 or img_name.find('\\audio\\') >= 0 or img_name.find('\\json\\') >= 0 or img_name.find('\\skilleffect\\') >= 0:
                        if argv_type.lower() in ['ios','android','wp8']:
                            row_texts = row_texts + '\t["%s"]={"%s",%d,"%s"},\n'%(os.path.splitext(img_name)[0].replace('\\','#'),type_img_name,type_flag,type_format)
                        else:
                            raise
                    else:
                        if argv_type.lower() in ['ios','android','wp8']:
                            row_texts = row_texts + '\t["%s"]={"%s",%d,"%s"},\n'%(os.path.splitext(os.path.basename(img_name))[0],type_img_name,type_flag,type_format)
                        else:
                            raise
    
    #遍历目录
    path_dict = {}
    walkpath("res",path_dict)
    
    for row_key,row_value in path_dict.iteritems():
        #处理图片
        for j in xrange(0,len(row_value)):
            #拆分目录
            img_path = row_key
            img_name = row_value[j]
            if img_name.find('.png') >= 0 or \
            img_name.find('.mp3') >= 0 or \
            img_name.find('.caf') >= 0 or \
            img_name.find('.m4a') >= 0 or \
            img_name.find('.ExportJson') >= 0 or \
            img_name.find('.json') >= 0 or \
            img_name.find('.csb') > 0 or \
            img_name.find('.plist') > 0 or \
            img_name.find('.ogg') >= 0 :
                pass
            else:
                continue
            
            img_flag = getImageFlag(img_name)

            #json文件夹只处理ExportJson文件
            if img_flag == IMAGE_FLAG_JSON: 
                if img_name.find('\\equip\\') >= 0:
                    if img_name.find('.ExportJson') < 0 and img_name.find('.plist') < 0:
                        continue
                else:
                    if img_name.find('.ExportJson') < 0:
                        continue

            #map文件夹只处理json文件
            if img_flag == IMAGE_FLAG_MAP and img_name.find('.json') < 0:
                continue

            #csb文件夹只处理csb文件
            if img_flag == IMAGE_FLAG_CSB and img_name.find('.csb') < 0:
                continue
            
            #查找是否已经被plist,win32不做plist
            continue_flag = getPlistedFlag(img_name,plist_dict,argv_type)

            if continue_flag:
                continue

            
            #查找是否有同名plist

            if img_flag == IMAGE_FLAG_NORMAL:
                found_flag = getPlistExistedFlag(img_name,path_dict,row_key)
                if found_flag:
                    row_texts = row_texts + '\t["%s"]={"%s",%d,""},\n'%(os.path.splitext(os.path.basename(img_name))[0],os.path.splitext(img_name.replace('\\','/'))[0],1)
                    continue

            #查找是否多平台文件
            continue_flag,target_name = getPublicresFlag(img_name,publicres_dict,argv_platform)

            if continue_flag:
                continue
            else:
                img_name = target_name

            #查找是否多语言文件
            continue_flag,target_name = getLanguageresFlag(img_name,languageres_dict,argv_lang)

            if continue_flag:
                continue
            else:
                img_name = target_name


            #产生图像格式
            type_format = getImageType(img_name,argv_type)

            type_flag = 0
            type_img_name = os.path.splitext(img_name.replace('\\','/'))[0]
            type_img_ext = os.path.splitext(img_name.replace('\\','/'))[1]
            if type_img_ext.lower() != '.png':
                #音效文件特殊处理
                if img_name.find('res\\audio\\') >= 0:
                    if img_name.find('\\'+argv_type.lower()+'\\') <= 0:
                        continue
                    else:
                        img_name = img_name.replace('\\'+argv_type.lower()+'\\','\\')

                type_img_name = img_name.replace('\\','/')
                if img_name.find('.plist') > 0:
                    type_flag = 1
                else:
                    type_flag = 0
            else:
                if argv_type.lower() == 'ios':
                    type_img_name = type_img_name + '.plist'
                    type_flag = 1
                elif argv_type.lower() == 'android':
                    if type_format == 'none':
                        type_img_name = img_name.replace('\\','/')
                        type_flag = 0
                    else:
                        type_img_name = type_img_name + '.plist'
                        type_flag = 1
                elif argv_type.lower() == 'wp8':
                    if type_format == 'none':
                        type_img_name = img_name.replace('\\','/')
                        type_flag = 0
                    else:
                        type_img_name = type_img_name + '.plist'
                        type_flag = 1
                else:
                    type_img_name = img_name.replace('\\','/')
            if img_name.find('\\ui\\') >= 0 or img_name.find('\\audio\\') >= 0 or img_name.find('\\json\\') >= 0 or img_name.find('\\skilleffect\\') >= 0:
                if argv_type.lower() in ['ios','android','wp8']:
                    row_texts = row_texts + '\t["%s"]={"%s",%d,"%s"},\n'%(os.path.splitext(img_name)[0].replace('\\','#'),type_img_name,type_flag,type_format)
                else:
                    row_texts = row_texts + '\t["%s"]={"%s",%d,"%s"},\n'%(os.path.splitext(img_name)[0].replace('\\','#'),type_img_name,type_flag,type_format)
            else:
                if argv_type.lower() in ['ios','android','wp8']:
                    row_texts = row_texts + '\t["%s"]={"%s",%d,"%s"},\n'%(os.path.splitext(os.path.basename(img_name))[0],type_img_name,type_flag,type_format)
                else:
                    row_texts = row_texts + '\t["%s"]={"%s",%d,"%s"},\n'%(os.path.splitext(os.path.basename(img_name))[0],type_img_name,type_flag,type_format)


    client_output_dict = {}
    client_output_dict["$RESPATH$"] = row_texts
    gen_file(client_template, client_output, client_output_dict, False)
    
    print 'plist ok! start convert!'
    
    #处理文件
    
    if argv_type == 'win32':

        safeRmTree("..\\..\\client\\res")

        import time
        time.sleep(2)
         
        while os.path.exists("..\\..\\client\\res"):
            pass

        shutil.copytree('res', "..\\..\\client\\res",False,ignoreFile)
        if os.path.exists("..\\..\\client\\res\\audio"):
            shutil.rmtree("..\\..\\client\\res\\audio", True)
            os.makedirs("..\\..\\client\\res\\audio")
        #win32音效特殊处理
        for file_name in os.listdir("res\\audio\\win32\\"):        
            sub_path = os.path.join("res\\audio\\win32\\", file_name)
            if os.path.isdir(sub_path):
                continue
            else:
                safeCopy(sub_path,"..\\..\\client\\res\\audio")
                

        #公共资源改名覆盖
        for publicres_key in publicres_dict.iterkeys():
            print 'win32 copy %s to %s'%("..\\..\\client\\"+publicres_key+"_"+argv_platform+".png","..\\..\\client\\"+publicres_key+".png")
            shutil.copy("..\\..\\client\\"+publicres_key+"_"+argv_platform+".png","..\\..\\client\\"+publicres_key+".png")
        
        #多语言资源改名覆盖
        if argv_lang != 'gbk' and argv_lang != 'multi':
            for languageres_key in languageres_dict.iterkeys():
                print 'win32 copy %s to %s'%("..\\..\\client\\"+languageres_key+"_"+argv_lang+".png","..\\..\\client\\"+languageres_key+".png")
                shutil.copy("..\\..\\client\\"+languageres_key+"_"+argv_lang+".png","..\\..\\client\\"+languageres_key+".png")

        return
    
    #处理配置的plist
    safeRmTree("temp\\")

    convert_flag = False
    
    for row_key,row_value in plist_dict.iteritems():
        #处理图片
        
        convert_flag = False
        
        for j in xrange(0,len(row_value)):
            #拆分目录
            img_flag = row_value[j][0]
            img_name = row_value[j][1]
            img_format = row_value[j][2]
            
            img_path = os.path.dirname(img_name) + '\\'
            
            if img_flag == 4:
                img_path = ""
            
            img_flag = getImageFlag(img_name)
            copy_flag = 1
            if img_flag == IMAGE_FLAG_JSON or img_flag == IMAGE_FLAG_MAP or img_flag == IMAGE_FLAG_CSB:
                copy_flag = 0


            if row_key.lower() == 'none':
                if img_name.find('\\ui\\') >= 0 or img_name.find('\\audio\\') >= 0 or img_name.find('\\json\\') >= 0 or img_name.find('\\skilleffect\\') >= 0:
                    pass
                else:
                    img_path = ''

            if not os.path.exists("temp\\"+img_path):
                os.makedirs("temp\\"+img_path)
            

            #查找是否多平台文件
            continue_flag,target_name = getPublicresFlag(img_name,publicres_dict,argv_platform)

            if continue_flag:
                continue
            else:
                img_publicres_name = target_name

            #查找是否多语言文件
            continue_flag,target_name = getLanguageresFlag(img_name,languageres_dict,argv_lang)

            if continue_flag:
                continue
            else:
                img_publicres_name = target_name


            if not os.path.exists(img_name):
                print img_name,"not exists!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            else:
                safeCopy(img_name,"temp\\"+img_path+os.path.basename(img_publicres_name))                    
               
            if img_name.replace('\\','/') in diff_list :                
                convert_flag = True
                
            if row_key.lower() == 'none':
                if (diff_flag and convert_flag) or not diff_flag:
                    cmd_text = "res\\xcopy.bat %s temp %s 0 %d %s"%('..\\..\\outputClient\\'+argv_type+'\\'+os.path.splitext(img_publicres_name)[0],getFormatFlag(argv_type,img_format),copy_flag,img_path)
                    os.system(cmd_text)
                    safeRmTree("temp\\")
                    convert_flag = False
                else:
                    safeRmTree("temp\\")
                    convert_flag = False


         
        if row_key.lower() != 'none':            
            if (diff_flag and convert_flag) or not diff_flag:
                cmd_text = "res\\xcopy.bat %s temp %s 1 %d"%('..\\..\\outputClient\\'+argv_type+'\\'+row_key,getFormatFlag(argv_type,img_format),copy_flag)
                os.system(cmd_text)
                #如果目标图没有生成，那么抛异常
                if (not os.path.exists('..\\..\\outputClient\\'+argv_type+'\\'+row_key+'.png')) and (not os.path.exists('..\\..\\outputClient\\'+argv_type+'\\'+row_key+'.pvr.ccz')) and (not os.path.exists('..\\..\\outputClient\\'+argv_type+'\\'+row_key+'.dds')):
                    raise

                safeRmTree("temp\\")
            else:
                safeRmTree("temp\\")



    #遍历处理其他文件
    for row_key,row_value in path_dict.iteritems():
        #处理图片
        for j in xrange(0,len(row_value)):
            #拆分目录
            img_path = row_key
            img_name = row_value[j]

            img_format = 'none'

            img_path = os.path.dirname(img_name) + '\\'
            
            if img_name.find('.png') >= 0 or \
            img_name.find('.mp3') >= 0 or \
            img_name.find('.caf') >= 0 or \
            img_name.find('.m4a') >= 0 or \
            img_name.find('.ExportJson') >= 0 or \
            img_name.find('.json') >= 0 or \
            img_name.find('.tmx') >= 0 or \
            img_name.find('.plist') >= 0 or \
            img_name.find('.ogg') >= 0 :
                pass
            else:
                continue

            img_flag = getImageFlag(img_name)
            copy_flag = 1
            if img_flag == IMAGE_FLAG_JSON or img_flag == IMAGE_FLAG_MAP or img_flag == IMAGE_FLAG_CSB:
                copy_flag = 0


            #查找是否已经被plist,win32不做plist
            continue_flag = getPlistedFlag(img_name,plist_dict,argv_type)

            if continue_flag:
                continue

            #查找是否有同名plist
            if img_flag == IMAGE_FLAG_NORMAL:
                found_flag = getPlistExistedFlag(img_name,path_dict,row_key)

                if found_flag:
                    #复制过去
                    safeCopy(img_name,"..\\..\\outputClient\\"+argv_type+'\\'+img_path)
                    img_plist = os.path.splitext(img_name)[0]+'.plist'
                    safeCopy(img_plist,"..\\..\\outputClient\\"+argv_type+'\\'+img_path)            
                    continue

            #查找是否多平台文件
            continue_flag,target_name = getPublicresFlag(img_name,publicres_dict,argv_platform)

            if continue_flag:
                continue
            else:
                img_publicres_name = target_name

            #查找是否多语言文件
            continue_flag,target_name = getLanguageresFlag(img_name,languageres_dict,argv_lang)

            if continue_flag:
                continue
            else:
                img_publicres_name = target_name


            convert_flag = False
            if img_name.replace('\\','/') in diff_list :
                convert_flag = True
            
            if (diff_flag and convert_flag) or not diff_flag:
                pass
            else:
                continue
            

            #产生图像格式
            img_format = getImageType(img_name,argv_type)

            img_ext = os.path.splitext(img_name.replace('\\','/'))[1]
            if img_ext.lower() != '.png':
                
                if img_flag == IMAGE_FLAG_NORMAL:

                    #音效文件特殊处理
                    if img_path.find('res\\audio\\') >= 0:
                        if img_path.find('\\'+argv_type.lower()+'\\') <= 0:
                            continue
                        else:
                            img_path = img_path.replace('\\'+argv_type.lower()+'\\','\\')

                    safeCopy(img_name,"..\\..\\outputClient\\"+argv_type+'\\'+img_path)

                elif img_flag == IMAGE_FLAG_MAP:
                    if img_name.find('.tmx') >= 0 or img_name.find('.json') >= 0:

                        with open(img_name, 'r') as fr:
                            content = fr.read()

                        content = content.replace(".png",".pvr.ccz")

                        safeWrite("..\\..\\outputClient\\"+argv_type+'\\'+img_path+os.path.basename(img_name),content)

                    else:
                        safeCopy(img_name,"..\\..\\outputClient\\"+argv_type+'\\'+img_path)

                elif img_flag == IMAGE_FLAG_JSON:
                    safeCopy(img_name,"..\\..\\outputClient\\"+argv_type+'\\'+img_path)

                print 'copy '+img_name
            else:
                if img_name.find('\\ui\\') >= 0 or img_name.find('\\audio\\') >= 0 or img_name.find('\\json\\') >= 0 or img_name.find('\\skilleffect\\') >= 0:
                    pass
                else:
                    img_path = ''
            

                if not os.path.exists(img_name):
                    print img_name,"not exists!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                else:
                    safeCopy(img_name,"temp\\"+img_path+os.path.basename(img_publicres_name))                    
                               
                cmd_text = "res\\xcopy.bat %s temp %s 0 %d %s"%("..\\..\\outputClient\\"+argv_type+'\\'+os.path.splitext(img_publicres_name)[0],getFormatFlag(argv_type,img_format),copy_flag,img_path)
                os.system(cmd_text)
                safeRmTree("temp\\")
              

if __name__ == '__main__':
    argv_type = sys.argv[1]
    argv_line = sys.argv[2]
    argv_platform = sys.argv[3]
    argv_nopic = sys.argv[4]
    argv_lang = sys.argv[5]
    argv_conftype = sys.argv[6]

    argv_start = -1
    argv_end = -1

    if len(sys.argv) != 9:
        argv_start = -1
        argv_end = -1
    else:
        argv_start = int(sys.argv[7])
        argv_end = int(sys.argv[8])
    
    convertImg(argv_type,argv_line,argv_platform,argv_lang,argv_start,argv_end)
        
