import os
import shutil


# file = '/users/nickbautista/desktop/picturestobemoved/linkedin-pic copy.png'
# destDir = '/users/nickbautista/desktop/picturesmovedhere'

# shutil.move(file, destDir)

# print("{} was moved to {}".format(file, destDir))

destDir = '/users/nickbautista/desktop/picsinone'

for root, dirs, files in os.walk("/users/nickbautista/desktop/pics"):
	for f in files:
		if '.png' in f:
			fullFile = os.path.join(root, f)
			# print(fullFile)	
			shutil.move(fullFile, destDir)

			
print("Check {} for the pics.".format(destDir))