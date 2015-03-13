# Cloverleaf
API to Flat Files and More

Cloverleaf is a general purpose API to flat file converter. It will make an http request to an API source and convert any list
(javascript array) component into a flat file. If the API source provides a 'flatFileSpec' (ie, is LightningPipe), it will 
generate a file that matches the spec. If not, it will generate a flat file with column names that are a Javascript dotted pathes
(eg, Person.Home.City).

