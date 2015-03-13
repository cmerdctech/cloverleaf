#!/bin/bash
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Guardian#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Guardians.txt -ah
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Schedule#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Schedules.txt -ah
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/010/segments/Student_Enrolled#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Students.txt -ah

$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/030/segments/Guardian#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Guardians.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/030/segments/Schedule#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Schedules.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/030/segments/Student_Enrolled#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Students.txt -a

$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/035/segments/Guardian#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Guardians.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/035/segments/Schedule#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Schedules.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/035/segments/Student_Enrolled#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Students.txt -a

$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/050/segments/Guardian#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Guardians.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/050/segments/Schedule#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Schedules.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/050/segments/Student_Enrolled#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Students.txt -a

$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/060/segments/Guardian#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Guardians.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/060/segments/Schedule#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Schedules.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/060/segments/Student_Enrolled#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Students.txt -a

$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/099/segments/Guardian#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Guardians.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/099/segments/Schedule#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Schedules.txt -a
$cloverleaf http://127.0.0.1:8000/uff/1.0/districts/Albany/schools/099/segments/Student_Enrolled#Data?sendFlatSpecs=true $testDestDir/AlbanyCommands/Students.txt -a
