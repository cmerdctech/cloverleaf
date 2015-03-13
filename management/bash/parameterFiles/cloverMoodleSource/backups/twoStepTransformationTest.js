{
    "input": [    
    {"source":"http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Address_Contact?sendFlatSpecs=true","destination":"Address_Contact", "path":"Data.Address_Contact", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Course?sendFlatSpecs=true","destination":"Course", "path":"Data.Course", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Section_Staff?sendFlatSpecs=true","destination":"Section_Staff", "path":"Data.Section_Staff", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Section_Student?sendFlatSpecs=true","destination":"Section_Student", "path":"Data.Section_Student", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Section?sendFlatSpecs=true","destination":"Section", "path":"Data.Section", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Student_Base?sendFlatSpecs=true","destination":"Student_Base", "path":"Data.Student_Base", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Student_Enrollment?sendFlatSpecs=true","destination":"Student_Enrollment", "path":"Data.Student_Enrollment", "switches":{"header":false, "append":true}}
],

    "transform": [
    {
        
        "type":"sqlizer2",
        "name":"mainTest",
		"parameters":{
		"input":[
			{"name":"Address_Contact"},
			{"name":"Course"},
			{"name":"Section_Staff"},
			{"name":"Section_Student"},
			{"name":"Section"},
			{"name":"Student_Base"},
			{"name":"Student_Enrollment"}
		],
		"process":[
			{"query":"create table Student_Enrolled as select 'a' as 'marker', * from Student_Base left join Address_Contact on Student_Base.studentuniqueidentifier=Address_Contact.studentuniqueidentifier"},
			{"query":"create table Schedule as select 'b' as 'marker', * from Section_Student inner join Section_Staff on ((Section_Student.courseNumber=Section_Staff.courseNumber) and (Section_Student.sectionNumber=Section_Staff.sectionNumber))"},
			{"query":"create table Guardian as select 'c' as 'marker', * from Address_Contact"}
		],
		"export":[
			{"tableName":"Student_Enrolled", "as":"A"},
			{"tableName":"Schedule", "as":"B"},
			{"tableName":"Guardian", "as":"C"}
		]
		}

    
    },
    
    {
        
        "type":"sqlizer2",
        "name":"second step",
		"parameters":{
		"input":[
			{"name":"Student_Enrolled"},
			{"name":"Schedule"},
			{"name":"Guardian"}
		],
		"process":[
			{"query":"create table test1 as select districtCode from A"}
		],
		"export":[
			{"tableName":"test1", "as":"test1.txt"}
		]
		}

    
    }
    
    ],

    "output": {
        "type": "file",
        "context": {
            "parentPath": "/Users/tqwhite/testLinkpoint/testDataDest/AlbanyJsonTest/"
        },
        "control": {
            "append": "false",
            "header": "true"
        }
    }
}
