{
    "input": [  


{"source":"http://127.0.0.1:8001/uff/1.0/districts/Albany/schools/010/segments/Guardian?sendFlatSpecs=true","destination":"Guardians", "path":"Data"}


],

    "transform": [],

    "output": {
        "type": "file",
        "context": {
            "parentPath": "zzStudentPlans/Albany/",
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
