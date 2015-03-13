{
    "input": [  
    {"source":"http://127.0.0.1:8000/uff/1.0/districts/PACT/schools/010/segments/Address_Contact?sendFlatSpecs=true","destination":"Address_Contact", "path":"Data.Address_Contact", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/PACT/schools/010/segments/Course?sendFlatSpecs=true","destination":"Course", "path":"Data.Course", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/PACT/schools/010/segments/Section_Staff?sendFlatSpecs=true","destination":"Section_Staff", "path":"Data.Section_Staff", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/PACT/schools/010/segments/Section_Student?sendFlatSpecs=true","destination":"Section_Student", "path":"Data.Section_Student", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/PACT/schools/010/segments/Section?sendFlatSpecs=true","destination":"Section", "path":"Data.Section", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/PACT/schools/010/segments/Student_Base?sendFlatSpecs=true","destination":"Student_Base", "path":"Data.Student_Base", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/PACT/schools/010/segments/Student_Enrollment?sendFlatSpecs=true","destination":"Student_Enrollment", "path":"Data.Student_Enrollment", "switches":{"header":false, "append":true}},

    {"source":"http://127.0.0.1:8000/uff/1.0/districts/PACT/schools/010/segments/JMC_User?sendFlatSpecs=true","destination":"JMC_User", "path":"Data.JMC_User", "switches":{"header":false, "append":true}}

],

    "transform": [ {
        
        "type":"applyFunction",
		"parameters":{
		"label":"generate Section_Staff.publicId",
		"input":[
			{"name":"Address_Contact"},
			{"name":"Course"},
			{"name":"Section_Staff"},
			{"name":"Section_Student"},
			{"name":"Section"},
			{"name":"Student_Base"},
			{"name":"Student_Enrollment"},
			{"name":"JMC_User"}
		],
		"process":[
		
			{
			"type":"map",
			"specs":
			{
				"sourceTableName":"Section_Staff",
				"destTableName":"Section_Staff",  
				"functionString":"function(item, inx, entire){item.publicId=qtools.hash(item.staffUniqueIdentifier); return item;}"
			}
			},
			{
			"type":"map",
			"specs":
			{
				"sourceTableName":"Address_Contact",
				"destTableName":"Address_Contact",  
				"functionString":"function(item, inx, entire){item.personId=qtools.newId(); item.userName=item.contactFullName.replace(/\\W+/g, '_'); return item;}"
			}
			}
		],
		"export":[
			{"tableName":"Address_Contact", "as":"Address_Contact"},
			{"tableName":"Course", "as":"Course"},
			{"tableName":"Section_Staff", "as":"Section_Staff"},
			{"tableName":"Section_Student", "as":"Section_Student"},
			{"tableName":"Section", "as":"Section"},
			{"tableName":"Student_Base", "as":"Student_Base"},
			{"tableName":"Student_Enrollment", "as":"Student_Enrollment"},
			{"tableName":"JMC_User", "as":"JMC_User"}
		]
		}

    
    },
    {
        
        "type":"sqlizer2",
		"parameters":{
		"label":"main extract",
		"fileName":"mainExtract",
		"input":[
			{"name":"Address_Contact"},
			{"name":"Course"},
			{"name":"Section_Staff"},
			{"name":"Section_Student"},
			{"name":"Section"},
			{"name":"Student_Base"},
			{"name":"Student_Enrollment"},
			{"name":"JMC_User"}
		],
		"process":[
{"query":"create table Enrollments as select distinct 'v2.10 enrollment staff primary' as version,  ss.publicId as courseId, ss.staffUniqueIdentifier as personId,  case when ss.PrimaryInstructorFlag='Y' then 'editingteacher'  else 'teacher' end as role,   c.courseAbbreviation || '_' ||  s.schoolYearBegin || '-' ||  s.schoolYearEnd || '_' ||  s.termAbbreviation || '_' ||  s.beginningPeriodNumber as 'classGroup'    from Course as c left join Section_Staff as ss on ss.courseNumber=c.courseNumber left join Section as s on s.sectionNumber=ss.sectionNumber  where trim(personId) <> '' and trim(personId) <> '' and trim(classGroup) <> ''  and trim(courseId) <> '' and ss.PrimaryInstructorFlag='Y'"},
{"query":"insert into Enrollments select distinct 'v2.10 enrollment students primary' as version,  ss.publicId as courseId, sst.studentUniqueIdentifier as personId, 'student' as role,  c.courseAbbreviation || '_' ||  s.schoolYearBegin || '-' ||  s.schoolYearEnd || '_' ||  s.termAbbreviation || '_' ||  s.beginningPeriodNumber as 'classGroup'    from Course as c left join Section_Staff as ss on ss.courseNumber=c.courseNumber left join Section as s on s.sectionNumber=ss.sectionNumber left join Section_Student as sst on sst.sectionNumber=s.sectionNumber  where trim(personId) <> '' and trim(personId) <> '' and trim(classGroup) <> ''"},
{"query":"create table NewCourses as select distinct 'v2.10 new courses primary' as version,  ss.lastName || '_' || ss.firstName as courseName, ss.lastName || '_' || ss.publicId as shortName, ss.publicId as courseId, ss.lastName || '_' || ss.firstName || '_Class' as summary,  '' as template, '' as startDate, '' as visibility, ss.schoolCode as categoryPath, ss.schoolCode as categoryId, ss.schoolCode as categoryName, ss.schoolCode as categoryDescription  from Course as c left join Section as s on s.courseNumber=c.courseNumber left join Section_Staff as ss on ss.sectionNumber=s.sectionNumber  where trim(courseName) <> '' and trim(shortName) <> '' and trim(courseId) <> ''"},
{"query":"create table Parents as select distinct 'v2.10 parent primary' as version,  j.personId as personId, j.studentUniqueIdentifier as studentUniqueIdentifier, 'parent' as role  from Address_Contact as j  where trim(personId) <> '' and trim(studentUniqueIdentifier) <> ''"},
{"query":"create table Users as select distinct 'v2.10 user parents primary and secondary' as version,  j.personId as personId, j.userName as userName, 'Te$tUs3r' as password, j.contactFirstName as firstName, j.contactLastName as lastName, j.contactEmail as email,  '' as city, '' as street, '' as phone1, '' as phone2, '' as grade, '' as gradYear,  j.schoolCode as schoolCode, 'PARENT' as department, 'US' as country, '' as description  from Address_Contact as j  where trim(personId) <> '' and trim(userName) <> '' and trim(password) <> '' and trim(firstName) <> '' and trim(lastName) <> '' and trim(email) <> '' "},
{"query":"insert into Users select distinct 'v2.10 user staff primary and secondary' as version,  j.staffUniqueIdentifier as personId, j.staffUniqueIdentifier as userName, 'Te$tUs3r' as password, j.firstName as firstName, j.lastName as lastName, j.lastName || '_' || j.firstName || '@emailaddress.edu' as email,  '' as city, '' as street, '' as phone1, '' as phone2, '' as grade, '' as gradYear,  j.schoolCode as schoolCode, 'STAFF' as department, 'US' as country, '' as description  from JMC_User as j  where trim(personId) <> '' and trim(userName) <> '' and trim(password) <> '' and trim(firstName) <> '' and trim(lastName) <> '' and trim(email) <> '' "},
{"query":"insert into Users select distinct 'v2.10 user students primary' as version,   sb.studentUniqueIdentifier as personId, sb.lastName || '_' || sb.firstName || '_' || substr(sb.studentUniqueIdentifier, 0, 4) as userName, sb.lastName as password, sb.firstName as firstName, sb.lastName as lastName, sb.lastName || '_' || sb.firstName || '@emailadr.edu' as email, ac.city as city, ac.address1 as street, ac.contactPhone1 as phone1, ac.contactPhone2 as phone2, sb.gradeLevel as grade, sb.graduationYear as gradYear, sb.schoolCode as schoolCode, 'STUDENT' as department, 'US' as country, '' as description   from Student_Base as sb left join Address_Contact as ac on  (ac.studentUniqueIdentifier=sb.studentUniqueIdentifier and LOWER(ac.addressTypeCode)=LOWER('primary1'))  where trim(personId) <> '' and trim(userName) <> '' and trim(password) <> '' and trim(firstName) <> '' and trim(lastName) <> '' and trim(email) <> ''  "}

		],
		"export":[
			{"tableName":"NewCourses", "as":"NewCourses"},
			{"tableName":"Enrollments", "as":"Enrollments"},
			{"tableName":"Users", "as":"Users"},
			{"tableName":"Parents", "as":"Parents"}
		]
		}
    },{
        
        "type":"applyFunction",
		"parameters":{
		"label":"concatenate courseGroup into strings",
		"input":[
			{"name":"NewCourses.txt"},
			{"name":"Enrollments.txt"},
			{"name":"Users.txt"},
			{"name":"Parents"}
		],
		"process":[
			{
			"type":"summarize",
			"specs":
			{
				"sourceTableName":"Enrollments",
				"destTableName":"classGroupNames", 
"indexFunction":"function(item, inx, entire) {  /* v2.10 courseGroup Index Function */  return (item.courseId) } ",
"summaryFunction":"function(item, inx, entire) {  /* v2.10 courseGroup Summary Function */  var termString = '',   alreadyIn=[],   outObj=item[0];     for (var i = 0, len = item.length; i < len; i++) {   var element = item[i];      if (element.role.toLowerCase()!='editingTeacher'.toLowerCase()){    continue;   }      if (alreadyIn.indexOf(element.classGroup)<0){   termString += element.classGroup + ',';   alreadyIn.push(element.classGroup);   }  }  termString = termString.replace(/,$/, '');   outObj.classGroup=termString;  return outObj; }"

			}
			},
		
			{
			"type":"map",
			"specs":
			{
				"sourceTableName":"Section_Staff",
				"destTableName":"Section_Staff",  
				"functionString":"function(item, inx, entire){item.publicId=qtools.hash(item.staffUniqueIdentifier); return item}"
			}
			}
		],
		"export":[
			{"tableName":"NewCourses", "as":"NewCourses"},
			{"tableName":"Enrollments", "as":"Enrollments"},
			{"tableName":"Users", "as":"Users"},
			{"tableName":"Parents", "as":"Parents"},
			{"tableName":"classGroupNames", "as":"classGroupNames"}
		]
		}

    
    },   {
        
        "type":"sqlizer2",
		"parameters":{
		"label":"apply courseGroup and remove dupes",
		"fileName":"cleanupTables",
		"input":[
			{"name":"NewCourses"},
			{"name":"Enrollments"},
			{"name":"Users"},
			{"name":"Parents"},
			{"name":"classGroupNames"}
		],
		"process":[
{"query":"update Enrollments /* v2.10 update courseGroups secondRoundSql*/ set classGroup=(select classGroup from classGroupNames where Enrollments.courseId=classGroupNames.courseId)"},
{"query":"create table /* v2.10 distinct enrollments secondRound */ EnrollmentsDistinct as select distinct * from Enrollments"}

		],
		"export":[
			{"tableName":"NewCourses", "as":"NewCourses"},
			{"tableName":"EnrollmentsDistinct", "as":"Enrollments"},
			{"tableName":"Users", "as":"Users"},
			{"tableName":"Parents", "as":"Parents"}
		]
		}
    }
    ],

    "output": {
        "type": "mysql",
        "context": {
            "parentPath": "/Users/tqwhite/testLinkpoint/testDataDest/PACTJsonTest/010/",
            "authParms":{
				"host":"qubuntu.local",
				"port":"3306",
				"user":"cloverleafTest",
				"password":"123123",
				"database":"cloverleafPact010"
			}
        },
        
		 "control":{
			"overwrite":[{"tableName":"NewCourses"}, {"tableName":"Enrollments"}],
			"overwrite":"all"
		 }
    }
}
