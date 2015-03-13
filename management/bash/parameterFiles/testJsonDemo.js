{
    "input": [  


{"source":"http://127.0.0.1:8000/uff/1.0/districts/Hawley/schools/010/segments/Guardian?sendFlatSpecs=true","destination":"Guardians", "path":"Data"}


],

    "transform": [],

    "output": {
        "type": "mysql",
        "context": {
            "parentPath": "/Users/tqwhite/testLinkpoint/testDataDest/zzStudentPlans/hawley2/",
            "header":true,
            "fileExtension":".txt",
            
            "databaseName":"zzStudentPlans",
			"authParmsFile":"qubuntuMysqlAuth.json"
        },
        
		 "control":{
			"overwriteReminderSelective":[{"tableName":"NewCourses"}, {"tableName":"Enrollments"}],
			"overwriteReminderDoNone":[],
			"overwrite":[]
		 }
    }
}
