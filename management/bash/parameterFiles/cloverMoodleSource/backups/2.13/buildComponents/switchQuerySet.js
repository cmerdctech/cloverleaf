(function(item) {
	switch (item.type) {
		case 'primary': return item.primaryMainExtractQueries; break; 
		case 'secondary': return item.secondaryMainExtractQueries; break;
		case 'skewed1': return item.skewed1; break;
		case 'skewed2': return item.skewed2; break;
	}
})