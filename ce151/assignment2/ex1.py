#! /bin/env python3

#Peter East - 1604513

import sys

def parse_line(line):
    line_split_by_spaces = line.split()

    student_number = line_split_by_spaces[0]
    year = line_split_by_spaces[1]
    degree_code = line_split_by_spaces[2]

    #parse names
    last_name = line_split_by_spaces[-1]

    first_names = line_split_by_spaces[3:-1]
    first_names = " ".join(first_names)

    return (student_number, year, degree_code, last_name, first_names)

def parsed_line_to_dict(parsed_line_in, byval = True):
    if byval:
        parsed_line = parsed_line_in[:]
    else:
        parsed_line = parsed_line_in
    out = {
        "student-number":parsed_line[0],
        "year":parsed_line[1],
        "degree-code":parsed_line[2],
        "last-name":parsed_line[3],
        "first-name":parsed_line[4]
    }
    return out

def print_fixed_width(data):
    if type(data) != dict:
        data = parsed_line_to_dict(data)

    print("{0:<32}  {1:<7}  {2:<6}  Year {3}".format(
        data["last-name"].title()+", "+data["first-name"].title(),
        data['student-number'],
        data['degree-code'],
        data['year']
    ))

def load_names_file():
    print("[WARN] Remember to remove the debug code at line 47")
    filename = "studs.txt"#input("Enter names filename:\n>>>")

    try:
        with open(filename) as names_file:
            names_lines = names_file.readlines()
    except FileNotFoundError:
        print("ERROR\n File '{0}' not found, terminating".format(filename), file=sys.stderr)
        sys.exit(-1)

    names_table = []
    for line in names_lines:
        names_table.append(parse_line(line))

    return names_table

def display_table(table, sort=False):

    if not sort:
        for line in table:
            print_fixed_width(line)
    else:
        new_table = table[:]
        new_table = sorted(sorted(new_table, key=lambda tp: tp[4]), key=lambda tp: tp[3])

        for row in new_table:
            print_fixed_width(row)

    return ""

def menuitem_degree_scheme(table):
    scheme = input("Enter degree scheme\n>>>")

    subtable = []

    # Generate a subtable
    for line in table:
        line_dict = parsed_line_to_dict(line)
        if line_dict['degree-code'] == scheme:
            subtable.append(line)

    if not len(subtable):
        return "Warning!\nNo results found for your query"
    else:
        # sort subtable by last name and by first name
        display_table(subtable, True)
        return "Query OK"

def menuitem_year_range(table):

    start = input("Enter the first year:\n>>>")
    end = input("Enter the end of the range: (if you only want to search one year, press enter)\n>>>")

    if end != "":

        years = list(range(int(start), int(end)+1))

    else:
        years = [int(start)]

    # generate a subtable
    subtable = []

    for line in table:
        if int(line[1]) in years:
            subtable.append(line)

    if not len(subtable):
        return "Warning!\nNo results found for your query"
    else:
        display_table(subtable, True)
        return "Query OK"

def menuitem_name(table):
    name = input("Name:\n>>>")

    subtable = []
    for line in table:
        if name == line[4]+" "+line[3]:
            subtable.append(line)

    if not len(subtable):
        return "Warning\nNo results found for '{0}'".format(name)

    else:
        display_table(subtable)

def control_loop(table):
    exit = False
    def quit(null):
        print("Bye!")
        sys.exit(1)
    menuitems = {
        "a":display_table,
        "d":menuitem_degree_scheme,
        "y":menuitem_year_range,
        "n":menuitem_name,
        "q":quit
    }

    while not exit:
        print("* Main Menu *")
        print("a - display all names")
        print("d - search by degree scheme")
        print("y - search by year range")
        print("n - search by name")
        print("q - quit")

        choice = input(">>>")[0]
        try:
            print(menuitems[choice](table))
        except KeyError:
            print("Invalid choice")

def debug_main():
    names = load_names_file()
    display_table(names)

    menuitem_degree_scheme(names)
    menuitem_year_range(names)

    control_loop(names)
debug_main()
# print(print_fixed_width(parse_line("1234556 2 G400 Bartholomew Homer Simpson")))
# print(print_fixed_width(parse_line("1234556 2 G400 Bartholomew Simpson")))
