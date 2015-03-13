
indexFunction = function(item, inx, entire) {
	return (item.courseNumber)
}


summaryFunction = function(item, inx, entire) {
	var termString = '',
		alreadyIn=[];
	

	for (var i = 0, len = item.length; i < len; i++) {
		var element = item[i];
		if (alreadyIn.indexOf(element.termAbbreviation)<0){
		termString += element.termAbbreviation + ', ';
		alreadyIn.push(element.termAbbreviation);
		}
	}
	termString = termString.replace(/, $/, '');

	return {
		courseNumber: inx,
		termList: termString
	}
}