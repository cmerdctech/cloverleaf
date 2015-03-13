# lightningPipe
The Sizzle of Data Through the Web

Lightning Pipe comprises two components. The eponymous one, Lightning Pipe, is an API generator. It refers to a data source, either
tab-delimitted files or MS SQL Server, in either case, it  provides three level access to it. It's initial application is education
and the heirarchy is District/School/DataSegment. For file system sources, these are interpreted from directory names. For 
a database source, a District is represented by a database and the next levels are interpreted from the data based on definitions
in the dictionary.

Cloverleaf is a general purpose API to flat file converter. It will make an http request to an API source and convert any list
(javascript array) component into a flat file. If the API source provides a 'flatFileSpec' (ie, is LightningPipe), it will 
generate a file that matches the spec. If not, it will generate a flat file with column names that are a Javascript dotted pathes
(eg, Person.Home.City).

In Version 2, support for simple mysql output was added.

In Version 3, the ability to transform data received from an API was added. Transformations can be expressed as Javascript functions
or SQL queries (made against an embedded Sqlite instance).
