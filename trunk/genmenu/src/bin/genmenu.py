#!/bin/python

import sys,os,re,shutil

#from output import red, green, blue, bold
import csv

from lxml import etree
from StringIO import StringIO

db = []

PORTDIR="/var/db/pkg/"
#PORTDIR = 'V:/Linux/portage/db'
# Move to applications
BASEDIR = '/usr/share/genmenu/'
APPSDIR = '/usr/share/genmenu/desktop'
MENUDIR = '/usr/share/genmenu/directory'
ENVDIR = '/etc/env.d/'

star = "  *  "
arrow = " >>> "
warn = " !!! "

class desktopfile:

    Header = "[Desktop Entry]"
    Name = "Name="
    Exec = "Exec="
    Icon = "Icon=/usr/share/genmenu/pixmaps/"
    Type = "Type=Application"

#    def __init__(self):

    def setName(self, Name):
        self.Name += Name

    def setIcon(self, Icon):
        self.Icon += Icon

    def setExec(self, Exec):
        self.Exec += Exec

    def getDesktopFile(self):
        return self.Header, self.Name, self.Exec, self.Icon, self.Type

    def writeDesktopFile(self, dest):
        try:
            file = open(dest , "w")
        except:
            sys.stderr.write("Unable to open " + dest + " for writing\n")
            sys.stderr.write("Verify that you have write permissions")
            return -1
        for x in self.Header, self.Name, self.Exec, self.Icon, self.Type:
            file.write(x + "\n")
        file.close()


def getHomeDir():
    ''' Try to find user's home directory, otherwise return /root.'''
    try:
        path1=os.path.expanduser("~")
    except:
        path1=""
    try:
        path2=os.environ["HOME"]
    except:
        path2=""
    try:
        path3=os.environ["USERPROFILE"]
    except:
        path3=""

    if not os.path.exists(path1):
        if not os.path.exists(path2):
            if not os.path.exists(path3):
                return '/root'
            else: return path3
        else: return path2
    else: return path1

HOME = getHomeDir()
ICONDIR = HOME + '/.local/share/applications/'
LOCALDIR = HOME + '/.local/share/desktop-directories/'
CONFIGDIR = HOME + '/.config/menus/'

def readcsv():
    '''Reads the db from the csv file'''
    try:
        reader = csv.reader(open(BASEDIR + "db.csv", "rb"))
    except:
        return -1
    for row in reader:
        db.append(row)

def appendcsv():
    '''Appends a line in the csv file'''
    '''Structure is as follow : cat-portage/appname,cat-pentoo,bin1[ bin2]'''
    writer = csv.writer
    #reader = csv.reader(open(BASEDIR + "db.csv", "rb"))
    #for row in reader:
    #    DB.append(row)

#REM Almost done, need to sanitize tabbed output
def listdb():
    print green("*****************************************")
    print green("    Listing all supported packages ")
    print green("*****************************************")
    print "Package\t\tMenu category"
    for y in range(db.__len__()):
        if db[y][0].__len__() < 15:
            tab="\t\t"
        else:
            tab="\t"
        print db[y][0] + tab + db[y][1]


def listpackages(pkgdir):
    """List packages installed as in the portage database directory (usually /var/db/pkg)"""
    packages = []
    categories = os.listdir(pkgdir)
    for category in categories:
        catdir = os.path.join(pkgdir, category)
        applications = os.listdir(catdir)
        for application in applications:
            packages.append(category + "/" + re.sub("-[0-9].*", "", application, 1))
    packages.sort()
    return packages
 
def settermenv():
    """This function creates the apropriate environment variable for the $E17TERM"""
    file = open(ENVDIR + "99pentoo-term" , "w")
    file.write("P2TERM=\"" + options.p2term + "\"")
    file.newlines
    file.close()

# Adds a desktop entry in the specified category, always under Pentoo.

def find_option(submenu, tag):
    for x in submenu.iterchildren():
        if x.tag == tag:
            return x
        else:
            tmp = find_option(x, tag)
            if not tmp == None:
                return tmp

def find_menu_entry(menu, submenu, option=None):
    for x in menu.iterchildren():
        if x.text == submenu:
            if not option == None:
                return find_option(x.getparent(), option)
            else:
                return x.getparent() 
        else:
            tmp = find_menu_entry(x, submenu, option)
            if not tmp == None:
                return tmp

def add_menu_entry(root_menu, category):
    menu = find_menu_entry(root_menu, category)
    if menu == None:
        new_menu_entry = etree.SubElement(find_menu_entry(root_menu, "Pentoo"), "Menu")
        new_name_entry = etree.SubElement(new_menu_entry, "Name")
        new_name_entry.text = category
        file = os.path.join(LOCALDIR, category + ".directory")
        if not options.simulate:
            if not os.path.exists(LOCALDIR):
                try:
                    os.makedirs(LOCALDIR)
                except:
                    sys.stderr.write("Unable to create " + LOCALDIR + "\n")
                    sys.stderr.write("Verify that you have write permissions in " + LOCALDIR + "\n")
                    return -1
            try:
                shutil.copyfile(os.path.join(MENUDIR, category + ".directory"), file)
            except:
                sys.stderr.write("Unable to copy " + category + ".directory" + " to " + LOCALDIR + "\n")
                sys.stderr.write("Verify that you have write permissions in " + LOCALDIR + "\n")
                return -1
        new_directory_entry = etree.SubElement(new_menu_entry, "Directory")
        new_directory_entry.text = category + ".directory"
        new_includelist = etree.SubElement(new_menu_entry, "Include")
        return new_includelist

def append_desktop_entry(menu, iconfile):
    new_desktop_entry = etree.SubElement(menu, "Filename")
    new_desktop_entry.text = iconfile

def create_desktop_entry(name, category, binname):
    '''This function creates a simple .desktop entry'''
    de = desktopfile()
    de.setName(name.capitalize())
    de.setIcon(category + ".png")
    de.setExec("$P2TERM -e launch " + binname + " -h")
    return de

def make_menu_entry(root_menu, iconfile, category):
    if not iconfile.endswith(".desktop"):
        nde = create_desktop_entry(iconfile, category, iconfile)
        file = os.path.join(ICONDIR, iconfile + ".desktop")
        nde.writeDesktopFile(file)
        iconfile += ".desktop"
    else:
        file = os.path.join(APPSDIR, iconfile)
        if os.path.exists(file):
            # Check if dry-run
            if options.verbose:
                print arrow + "Copying " + iconfile + " to " + ICONDIR
            if not options.simulate:
            # Copy the file
                if not os.path.exists(ICONDIR):
                    os.makedirs(ICONDIR)
                try:
                    shutil.copyfile(file, ICONDIR + iconfile)
                except:
                    sys.stderr.write("Unable to copy " + iconfile + " to " + ICONDIR + "\n")
                    sys.stderr.write("Verify that you have write permissions in " + ICONDIR + "\n")
                    return -1
        else:
            sys.stderr.write("File " + file + "does not exists \n")
            return -1
    menu = find_menu_entry(root_menu, category, "Include")
    if menu == None:
        menu = add_menu_entry(root_menu, category)
    append_desktop_entry(menu, iconfile)
        


def genxml(root_menu):
    '''Generate the applications.menu XMl file in the user's directory.'''
    dtd = etree.DTD("menu-1.0.dtd")
    if dtd.validate(root_menu) == 0:
        print dtd.error_log.filter_from_errors()
        return -1
    if options.verbose:
        #menu = etree.parse(root_menu)
        print etree.tostring(root_menu, pretty_print=True)
    if not options.simulate:
        if not os.path.exists(CONFIGDIR):
            os.makedirs(CONFIGDIR)
        root_menu.write(CONFIGDIR + '/applications.menu')

def main():
    '''
    This program is used to generate the menu in enlightenment for the pentoo livecd
    '''
    try:
        readcsv()
    except:
        print >> sys.stderr, "cannot read csv file"
        return -1

    if options.testmodule:
        a = desktopfile()
        a.setName("Toto")
        a.setExec("toto")
        a.setIcon("toto.png")
        a.writeDesktopFile("./toto.desktop")
        return 0
    
    if options.listsupported:
        listdb()
        return 0

    if options.simulate:
        print star + "Starting simulation"

    if options.listonly:
        print star + "Listing supported packages installed"
        print "Package\t\tIcon file\t\tMenu category"

    pkginstalled = []
    pkginstalled = listpackages(PORTDIR)
    notthere = []
    menu = etree.parse("applications.menu")
    root_menu = menu.getroot()

    for y in range(db.__len__()):
        if pkginstalled.__contains__(db[y][0]):
            if options.listonly:
                print db[y][0] + "\t" + db[y][2] + "\t\t" + db[y][1] + "\t"
            else:
                # calls makemenuentry file.eap, menu category
                for single_entry in db[y][2].split(" "):
                    try:
                        make_menu_entry(root_menu, single_entry, db[y][1])
                    except:
                        print >> sys.stderr, "Something went wrong, obviously..."
                        return -1
        else:
            notthere.append(db[y][0])

    #    settermenv()
    if options.vverbose:
        # Final move, show the unfound icons in the db
        print warn + "Missing applications :"
        print star + "The following applications are available but not installed"
        for i in range(notthere.__len__()):
            print arrow + notthere[i]
    #print etree.tostring(root_menu, pretty_print=True)
    genxml(menu)

if __name__ == "__main__":

    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-l", "--list", action="store_true", dest="listonly", default=False,
                      help="Show supported installed packages")
    parser.add_option("-T", "--test", action="store_true", dest="testmodule", default=False,
                      help="Testing module during dev")
    parser.add_option("-a", "--add", action="store_true", dest="addcsventry", default=False,
                      help="Test xml")
    parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False,
                      help="Show what's going on")
    parser.add_option("-V", "--very-verbose", action="store_true", dest="vverbose", default=False,
                      help="Show supported installed packages")
    parser.add_option("-L", "--list-supported", action="store_true", dest="listsupported", default=False,
                      help="Show supported installed packages")
    parser.add_option("-t", "--term", dest="p2term", default="xterm",
                      help="Sets the terminal used for cli-only tools")
    parser.add_option("-n", "--dry-run", action="store_true", dest="simulate", default=False,
                      help="Simulate only, show missing desktop files"
                           " and show what will be done")
    (options, args) = parser.parse_args()

    try:
        main()
    except KeyboardInterrupt:
        # If interrupted, exit nicely
        print >> sys.stderr, 'Interrupted.'
