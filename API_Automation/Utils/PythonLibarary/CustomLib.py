import os
import random
import string
testData={}
configTestData={}
class CustomLib:
    ROBOT_LIBRARY_SCOPE='Test Case'  
    @staticmethod
    def get_testData_From_PropertiesFile_withoutGlobal(propfile):
        testData={}
        try:
            file=open(propfile)
            for line in file:
                content=line.split("=")
                firstArgument=content[0]
                secondArgument=content[1]
                a=firstArgument.rstrip('\n')
                b=secondArgument.rstrip('\n')
                testData[a]=b
        except Exception as e:
            if hasattr(e, 'message'):
                print(e.message)
            else:
                print(e)
        finally:
            file.close()
            return testData
    
     
    @staticmethod
    def get_config_properties_without_Global(testdata_filename):
         print(testdata_filename)
         configpath=os.path.dirname(os.path.abspath(__file__))
         configpath=configpath.replace("Utils\\PythonLibarary", "Resource\\TestData")
         testdata_filename=configpath+"\\"+testdata_filename
         return CustomLib.get_testData_From_PropertiesFile_withoutGlobal((testdata_filename))       
       
def main():
    CustomLib.get_global_config_data()
   # CustomLib.get_testData_From_PropertiesFile()   

if __name__ == '__main__':
    main()
