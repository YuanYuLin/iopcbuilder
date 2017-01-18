import os

class DefconfigParser:
    file_name = ""
    comment_char = '#'
    sep_char = '='
    cfg_list = []

    def __init__(self, config_file_name):
        self.file_name = config_file_name

    def set_sep_char(self, val):
        self.sep_char = val

    def set_comment_char(self, val):
        self.comment_char = val

    def parse(self):
        is_comment_line = False
        content = file(self.file_name)

        for line in content:
            is_comment_line = False
            props = line.strip()
            if len(props) == 0:
                continue

            if props.startswith(self.comment_char):
                is_comment_line = True

            if not is_comment_line:
                idx = props.index(self.sep_char)
                str1 = props[:idx].strip()
                str2 = props[idx:].lstrip(self.sep_char)
                self.cfg_list.append({str1:str2})
            else:
                self.cfg_list.append({line:"RESERVED_LINE"})

    def set_config(self, key, val):
        for idx, item in enumerate(self.cfg_list):
            for _key, _val in item.iteritems():
                if _key == key:
                    print "Match " + key + ", " + val
                    self.cfg_list[idx] = {key:'"' + val + '"'}
                    return 
        print key + " Not Found"

    def get_config(self, key):
        for item in self.cfg_list:
            for _key, _val in item.iteritems():
                if _key == key:
                    return _val
        #return self.cfg[key]

    def show_configs(self):
        for item in self.cfg_list:
            for _key, _val in item.iteritems():
                if _val != "RESERVED_LINE":
                    print _key + "," + _val
                #else:
                    #print _key

    def save_configs(self, dest_file):
        print 'SAVE to ' + dest_file
        f = open(dest_file, 'w')
        for item in self.cfg_list:
            for _key, _val in item.iteritems():
                if _val == "RESERVED_LINE":
                    line = _key
                else:
                    line = _key + "=" + _val + os.linesep
                f.write(line)

        f.close()
