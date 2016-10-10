// Se inicializan las variables de los requerimientos de la aplicación
var express = require('express');
var expr = express();
var mysql = require('mysql');
var http = require("http");
var dato = "";
// Se crean las variables con las credenciales para la conexión
var connection = mysql.createConnection({
  host     : '192.168.131.22',
  user     : 'icesi',
  password : '12345',
  database : 'databaseD'

});
// Se realiza la conexión con la base de datos
connection.connect();
// Se obtiene el dato de la base de datos
var x = connection.query(
          'SELECT name FROM parcial',
          function(err,rows){
            if(err) throw err;
                var y= rows[0].name;
		dato=y;
        }
);
// Se finaliza la conexión y se muestra el dato en el servicio web a través de la dirección 192.168.130.21/data
connection.end();
expr.get('/data', function(req, res){
 res.send("Dato de la base de datos: "+ dato);
});

expr.listen(80, "192.168.131.21");

