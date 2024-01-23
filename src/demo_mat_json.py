# example in Python to read MAT and write JSON

import importlib
import subprocess

def check_module(module_name):
    try:
        importlib.import_module(module_name)
        return True
    except ImportError:
        return False

# check if scipy is installed
if not check_module('scipy'):
    print("Scipy is not installed.")
    install_scipy = input("Do you want to install scipy? (y/n): ").lower()
    if install_scipy == 'y':
        try:
            import subprocess
            subprocess.check_call(['pip', 'install', 'scipy'])
            print("Scipy has been successfully installed.")
        except Exception as e:
            print(f"Error installing scipy: {e}")
    else:
        print("Scipy is required for this script. Please install it manually.")

# check if json module is installed
if not check_module('json'):
    print("Json module is not installed.")
    install_json = input("Do you want to install json module? (y/n): ").lower()
    if install_json == 'y':
        try:
            import subprocess
            subprocess.check_call(['pip', 'install', 'json'])
            print("JSON module has been successfully installed.")
        except Exception as e:
            print(f"Error installing json module: {e}")
    else:
        print("Json module is required for this script. Please install it manually.")

# now use scipy and JSON to convert MAT and JSON files
import scipy.io
import json

# replace example with the actual path to your MAT / JSON file
mat_file_path = '../test_data/pat1_NTP.mat'
json_file_path = '../test_data/pat1_NTP.json'
json_data = {} # initialize data

# load .MAT file
mat_contents = scipy.io.loadmat(mat_file_path)

for variable_name, variable_data in mat_contents.items():
    # ignore variables like __header__ from loadmat
    if not variable_name.startswith("__"):
        # access and list variables from the MAT file for further processing
        print(f"Variable Name: {variable_name}")
        print(f"Data:\n{variable_data}\n")

        # convert MATLAB array to a nested list
        if isinstance(variable_data, list):
            json_data[variable_name] = variable_data
        else:
            # convert other types to string but replace \n to comma
            json_data[variable_name] = str(variable_data).replace('\n',',')
                        

# write JSON data to a file
with open(json_file_path, 'w') as json_file:
    json.dump(json_data, json_file, indent=4)