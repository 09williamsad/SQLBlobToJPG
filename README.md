# SQLBlobToJPG
Simple SQL procedure for batch converting base 64 blob images in a microsoft SQL database to JPG.

Gets the blob base 64 strings using an SQL query then creates a temporary table to store them in for conversion.
Exports JPGs to the specified location on the server using BCP.
