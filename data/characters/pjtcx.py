import sys
import json

textfile = ''
newfile = ''
#TO USE THIS FILE, ENTER "python psychjsontocodenamexml.py <YOUR FILE NAME>.json" into your CLI
def convAnim(a):
    print('CONVERTING"' + a['anim'] + '"')
    b = '   <anim name="'+a['anim']+'" anim="'+a['name']+'"'
    if a['fps'] != 24: b+=' fps="'+str(a['fps'])+'"'
    b+=' loop="'+str(a['loop']).lower()+'"'
    offset = []
    for i in a['offsets']: offset.append(i)
    b+=' x="'+str(offset[0])+'"' 
    b+=' y="'+str(offset[1])+'"'
    indices = []
    for i in a['indices']: indices.append(i)
    if (a['indices'] != []):
        b+=' indices="'
        for i in indices:
            b+=str(i)
            if i != indices[len(indices)-1]:
                b+=','
        b+='"'
    b+='/>\n'
    print('CONVERTING"' + a['anim'] + '" SUCCESS')
    return b

ch = [['isPlayer="false"', 'dad'], ['isPlayer="true"', 'bf'], ['isPlayer="false" isGF="true"', 'gf']]
def sC():
    sc = 'isPlayer="false"'
    textfileee = open('config.json', "r").read()
    textfileee2 = json.loads(textfileee)
    if (textfileee2['askIfPlayer'] == True):
        sc = (input('What is the character type for ' + str(sys.argv[1]).rstrip('.json')+'? (dad/bf/gf): '))
        for i in range(len(ch)):
            if ch[i][1]==sc: sc = ch[i][0]
    if not sc.startswith('i'):
        print('wtffff invalid input!?!?!?, crashin!!!')
        sys.exit()

    return sc
def convert(jsonfile):
    #turns psych char json into codename xml
    jsonthing = json.loads(jsonfile)
    print('SUCCESSFULLY LOADED JSON')
    specialChoice = sC()
    print('CONVERTING')
    codenamefile = '<!DOCTYPE codename-engine-character>'
    codenamefile+='\n<character ' + specialChoice
    codenamefile+= ' flipX="'+str(jsonthing['flip_x']).lower()+'" holdTime="'+str(jsonthing['sing_duration'])+'"'
    print('CONVERTING CHARACTER POSITION')
    pos = []
    for i in jsonthing['position']: pos.append(i)
    if pos[0] != 0: codenamefile+=' x="'+str(pos[0])+'"' 
    if pos[1] != 0: codenamefile+=' y="'+str(pos[1])+'"' 
    print('CONVERTING CAMERA POSITION')
    campos = []
    for i in jsonthing['camera_position']: campos.append(i)
    if campos[0] != 0: codenamefile+=' camX="'+str(campos[0])+'"' 
    if campos[1] != 0: codenamefile+=' camY="'+str(campos[1])+'"'
    print('CONVERTING SCALE')
    if jsonthing['scale'] != 1: codenamefile+=' scale="'+str(jsonthing['scale'])+'"'
    #whyyy make true and false have to be camelcased python, whyyyyyy
    print('CONVERTING ANTIALIASING')
    if jsonthing['no_antialiasing'] != False: codenamefile+=' antialiasing="'+(str(not jsonthing['no_antialiasing']).lower())+'"'
    codenamefile+='''> <!-- CONVERTED VIA psychjsontocodenamexml.py by Burgerballs -->

'''
    print('MISC VARIABLES CONVERTED')
    for i in jsonthing['animations']:
        codenamefile+=convAnim(i)
    codenamefile+='\n</character>'
    return codenamefile
if str(sys.argv[1]).endswith('.json'):
    print(sys.argv[1],'is a JSON formatted file.')
    textfile = open(sys.argv[1], "r").read()
    print(textfile)
    f = open(str(sys.argv[1]).rstrip('.json') + '.xml', "w")
    newfile = convert(textfile)
    f.write(newfile)
    f.close()
    print('CONVERSION SUCCESSFUL, OPEN '+str(sys.argv[1]).rstrip('.json') + '.xml')
else:
    print('Error:',sys.argv[1],'is not a JSON formatted file.')