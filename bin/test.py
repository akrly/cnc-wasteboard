import FreeCAD
import Part

# Path to the SCAD file
scad_file_path = "./main.scad"

# Read the SCAD file and assign it to a Part object
s = Part.read(scad_file_path)

# Path to export the STEP file
step_file_path = "./mainsss.step"

try:
    # Export the Part object as a STEP file
    Part.export([s], step_file_path)
    FreeCAD.Console.PrintMessage("Part exported as a STEP file.")
except Exception as e:
    FreeCAD.Console.PrintError("Error occurred during export: " + str(e))

