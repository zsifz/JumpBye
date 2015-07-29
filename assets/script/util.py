#!/usr/bin/env python
# encoding: utf-8
import os
import sys
import xlrd
import types
from langconv import *

def _int(data):
    """str -> int"""
    if data == '':
        return 0
    return int(data)

def _float(data):
    """str -> int"""
    if data == '':
        return 0.0
    else:
        return float(data)

def _utf8(data):
    """unicode -> str encoding utf-8"""
    temp_data = data
    if type(data) not in [types.StringType,types.UnicodeType]:
        temp_data = str(data)
    return temp_data.encode('utf-8').strip()

def _j2f(data,jf_flag, argv_multi, argv_multi_fd, need_save = True):
    temp_data = data
    if type(data) not in [types.StringType,types.UnicodeType]:
        temp_data = str(data)
    utf8_data = temp_data.encode('utf-8').strip()
    if jf_flag == 'gbk':
        if need_save:
            argv_multi_fd.write(utf8_data+'\n')
    if jf_flag == 'big5':
        utf8_data = Converter('zh-hant').convert(utf8_data.decode('utf-8'))
        utf8_data = utf8_data.encode('utf-8')
    if jf_flag == 'en':
        if need_save:
            if argv_multi.has_key(utf8_data):
                utf8_data = argv_multi[utf8_data]
            else:
                utf8_data = 'not defined!!'
                print utf8_data,'not defined english version!'
                raise
    return utf8_data

def multilanguagefd():
    return open('../translate/temp.txt', 'a')

def multilanguage():
    book = xlrd.open_workbook('../translate/multilanguage.xls')
    sheet = book.sheet_by_name('multilanguage')
    temp_dict = dict()

    for i in xrange(1, sheet.nrows):
        #print sheet.cell_value(i,0),sheet.cell_value(i,1)
        temp_dict[_utf8(sheet.cell_value(i,0))] = _utf8(sheet.cell_value(i,1))

    return temp_dict



def converter_0(excel_file, configs, argv_jf = None, argv_multi = None, argv_multi_fd = None, need_save = True):
    """针对k-v格式且数据格式统一的转换函数，支持遍历多个sheet
    
    输出格式示例：
        1:["头盔", 1],
        2:["武器", 1],
        3:["魂器", 1]
    """
    book = xlrd.open_workbook(excel_file)
    output = {}
    
    for sheet_name, config in configs.iteritems():
        sheet = book.sheet_by_name(sheet_name)  # excel中一个sheet的内容
        print sheet.name
        
        rows_text = ''
        
        for i in xrange(1, sheet.nrows):
            # 循环sheet中的行
            row_dict = {}
            
            for j in xrange(sheet.ncols):
                # 循环sheet中的列
                if config['data_type'][j] == 'int':
                    row_dict['s' + str(j)] = _int(sheet.cell_value(i, j))
                elif config['data_type'][j] == 'str':
                    row_dict['s' + str(j)] = _utf8(sheet.cell_value(i, j))
                elif config['data_type'][j] == 'unicode':
                    #if excel_file == 'stringres.xls':
                    #    print _utf8(sheet.cell_value(i, j)),'   ',i,'   ',j
                    if argv_jf:
                        row_dict['s' + str(j)] = _j2f(sheet.cell_value(i, j),argv_jf, argv_multi, argv_multi_fd, need_save)
                    else:
                        row_dict['s' + str(j)] = _utf8(sheet.cell_value(i, j))
                elif config['data_type'][j] == 'float':
                    row_dict['s' + str(j)] = _float(sheet.cell_value(i, j))
                else:
                    raise Exception('data type error')
            
            row_data = config['data_template'] % row_dict
            
            rows_text = rows_text + ' ' * 12 + row_data + ',\n'
        
        output[config['placeholder']] = rows_text[:-2]

    return output

def converter_1(excel_file, sheet_name, isServer = False ):
    """针对k-v格式但数据格式不统一的转换函数
    仅支持不定长列表，且列表中元素为数字
    
    数据格式示例：
        377:[1],
        520:[1, 2, 3],
        807:[1, 2, 3, 5, 6]
    """
    book = xlrd.open_workbook(excel_file)
    sheet = book.sheet_by_name(sheet_name)
    print sheet.name
    
    data_template = '%(s0)d:[%(s1)s]'
    if isServer == False:
        data_template = '[%(s0)d] = {%(s1)s}'
    
    rows_text = ''
    
    for i in xrange(1, sheet.nrows):
        # 循环sheet中的行
        row_dict = {}
        row_list = ''
        row_dict['s0'] = _int(sheet.cell_value(i, 0))
        
        for j in xrange(1, sheet.ncols):
            # 循环sheet中的列
            if sheet.cell_value(i, j) != '':
                row_list = row_list + str(_int(sheet.cell_value(i, j))) + ', '
        
        if row_list <> '':
            row_list = row_list[:-2]
        
        
        row_dict['s1'] = row_list
        row_data = data_template % row_dict
        rows_text = rows_text + ' ' * 12 + row_data + ',\n'
        
    return rows_text[:-2]

def converter_2(excel_file, sheet_name):
    """针对特定数组的转换函数

    数据格式示例：
        [[10, 1, 2], [10, 2, 4], [10, 3, 6]]
    """
    book = xlrd.open_workbook(excel_file)
    sheet = book.sheet_by_name(sheet_name)
    print sheet.name

    rows_list = []

    for i in xrange(1, sheet.nrows):
        # 循环sheet中的行
        row_list = []
        for j in xrange(sheet.ncols):
            # 循环sheet中的列
            row_list.append(_int(sheet.cell_value(i, j)))
        
        rows_list.append(row_list)

    return str(rows_list)

def converter_3(excel_file, configs, argv_jf = None, argv_multi = None, argv_multi_fd = None, need_save = True):
    """纯粹文本替换的转换模式，支持遍历多个sheet

    输出格式示例：
        public static const JianLingNan:String = "JianLingNan";
    """
    book = xlrd.open_workbook(excel_file)

    for sheet_name, config in configs.iteritems():
        sheet = book.sheet_by_name(sheet_name)  # excel中一个sheet的内容
        print sheet.name

        rows_text = ''

        for i in xrange(1, sheet.nrows):
            # 循环sheet中的行
            row_dict = {}

            for j in xrange(sheet.ncols):
                # 循环sheet中的列
                if config['data_type'][j] == 'int':
                    row_dict['s' + str(j)] = _int(sheet.cell_value(i, j))
                elif config['data_type'][j] == 'str':
                    row_dict['s' + str(j)] = _utf8(sheet.cell_value(i, j))
                elif config['data_type'][j] == 'unicode':
                    if argv_jf:
                        row_dict['s' + str(j)] = _j2f(sheet.cell_value(i, j),argv_jf, argv_multi, argv_multi_fd, need_save)
                    else:
                        row_dict['s' + str(j)] = _utf8(sheet.cell_value(i, j))
                else:
                    raise Exception('data type error')

            row_data = config['data_template'] % row_dict

            rows_text = rows_text + ' ' * 12 + row_data + ',\n'

    return rows_text[:-2]

def gen_file(input_file, output_file, output_dict, isServer = False):
    """生成配置文件
    """
    with open('template' + os.path.sep + input_file, 'r') as f:
        content = f.read()

    for k, v in output_dict.iteritems():
        content = content.replace(k, v)
    
    if isServer:
        with open('../../outputServer' + os.path.sep + output_file, 'w') as f:
            f.write(content)
    else:
        with open('../../outputClient' + os.path.sep + output_file, 'w') as f:
            f.write(content)

def gen_adminserver_file(input_file, output_file, output_dict):
    """生成配置文件
    """
    with open('template' + os.path.sep + input_file, 'r') as f:
        content = f.read()

    for k, v in output_dict.iteritems():
        content = content.replace(k, v)
    
    with open('../../outputAdminServer' + os.path.sep + output_file, 'w') as f:
        f.write(content)
