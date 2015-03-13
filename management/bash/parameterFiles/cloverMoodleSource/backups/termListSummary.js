
    {
        
        "type":"applyFunction",
		"parameters":{
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
			"type":"summarize",
			"specs":
			{
				"sourceTableName":"Section",
				"destTableName":"Section_TermList", 
				"indexFunction":"function(item, inx, entire) {   return (item.sectionNumber) }",
				"summaryFunction":"function(item, inx, entire) {  var termString = '',   alreadyIn=[];     for (var i = 0, len = item.length; i < len; i++) {   var element = item[i];   if (alreadyIn.indexOf(element.termAbbreviation)<0){   termString += element.termAbbreviation + ', ';   alreadyIn.push(element.termAbbreviation);   }  }  termString = termString.replace(/, $/, '');   return {   courseNumber: inx,   termList: termString  } }"

			}
			},
		
			{
			"type":"map",
			"specs":
			{
				"sourceTableName":"Section_Staff",
				"destTableName":"Section_Staff",  
				"functionString":"function(item, inx, entire){item.publicId=qtools.hash(item.staffUniqueIdentifier); return item;}"
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
			{"tableName":"JMC_User", "as":"JMC_User"},
			{"tableName":"Section_TermList", "as":"Section_TermList"}
		]
		}

    
    }