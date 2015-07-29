#!/usr/bin/env python
# encoding:	utf-8
import os
#from __future__ import	with_statement

import xlrd

import sys
sys.path.append("../")

from script.util import	_int
from script.util import	_utf8
from script.util import	_j2f
from script.util import	multilanguagefd
from script.util import	multilanguage
from script.util import	converter_0
from script.util import	converter_3
from script.util import	gen_file
from script.util import	gen_adminserver_file

def	sampledb():
	excel_file = 'sampledb.xls'
	client_template	= 'sampledb.lua'
	client_output =	'sampledb.lua'
	
	client_configs = {
		'sample':{
			'data_type':['int','unicode','unicode','int', 'int', 'int',	'int', 'int'],
			'data_template':'[%(s0)d]={"%(s1)s","%(s2)s",%(s3)d,%(s4)d,%(s5)d,%(s6)d,%(s7)d}',
			'placeholder':'$SAMPLEDB$'
		}
	}
	client_output_dict = converter_0(excel_file, client_configs)
	gen_file(client_template, client_output, client_output_dict)
def	stringdb():
	excel_file = 'stringdb.xls'
	client_template	= 'stringdb.lua'
	client_output =	'stringdb.lua'
	
	client_configs = {
		'stringdb':{
			'data_type':['str','unicode'],
			'data_template':'["%(s0)s"]="%(s1)s"',
			'placeholder':'$STRINGDB$'
		}
	}
	client_output_dict = converter_0(excel_file, client_configs)
	gen_file(client_template, client_output, client_output_dict)

if __name__	== '__main__':
	stringdb()