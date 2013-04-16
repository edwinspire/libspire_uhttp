//
//
//  Author:
//       Edwin De La Cruz <admin@edwinspire.com>
//
//  Copyright (c) 2013 edwinspire
//  Web Site http://edwinspire.com
//
//  Quito - Ecuador
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.


//New file source
using Gee;
using GLib;
//using Sqlite;

namespace edwinspire.uHttp{

const string VERSION = "uHttp Server Version 0.1 Alpha";

/*
	public enum DateFormat {
		HTTP,
		COOKIE,
		RFC2822,
		ISO8601_COMPACT,
		ISO8601_FULL,
		ISO8601,
		ISO8601_XMLRPC
	}
*/
[Description(nick = "HTTP Version", blurb = "")]
	public enum HTTPVersion {
		@1_0,
		@1_1
	}

[Description(nick = "HTTP Status Code", blurb = "")]
	public enum StatusCode {
		NONE,
		CONTINUE,
		SWITCHING_PROTOCOLS,
		PROCESSING,
		OK,
		CREATED,
		ACCEPTED,
		NON_AUTHORITATIVE,
		NO_CONTENT,
		RESET_CONTENT,
		PARTIAL_CONTENT,
		MULTI_STATUS,
		MULTIPLE_CHOICES,
		MOVED_PERMANENTLY,
		FOUND,
		MOVED_TEMPORARILY,
		SEE_OTHER,
		NOT_MODIFIED,
		USE_PROXY,
		NOT_APPEARING_IN_THIS_PROTOCOL,
		TEMPORARY_REDIRECT,
		BAD_REQUEST,
		UNAUTHORIZED,
		PAYMENT_REQUIRED,
		FORBIDDEN,
		NOT_FOUND,
		METHOD_NOT_ALLOWED,
		NOT_ACCEPTABLE,
		PROXY_AUTHENTICATION_REQUIRED,
		PROXY_UNAUTHORIZED,
		REQUEST_TIMEOUT,
		CONFLICT,
		GONE,
		LENGTH_REQUIRED,
		PRECONDITION_FAILED,
		REQUEST_ENTITY_TOO_LARGE,
		REQUEST_URI_TOO_LONG,
		UNSUPPORTED_MEDIA_TYPE,
		REQUESTED_RANGE_NOT_SATISFIABLE,
		INVALID_RANGE,
		EXPECTATION_FAILED,
		UNPROCESSABLE_ENTITY,
		LOCKED,
		FAILED_DEPENDENCY,
		INTERNAL_SERVER_ERROR,
		NOT_IMPLEMENTED,
		BAD_GATEWAY,
		SERVICE_UNAVAILABLE,
		GATEWAY_TIMEOUT,
		HTTP_VERSION_NOT_SUPPORTED,
		INSUFFICIENT_STORAGE,
		NOT_EXTENDED
	}

[Description(nick = "HTTP Request Method", blurb = "")]
public enum RequestMethod{
UNKNOW,
GET,
POST,
HEAD
}

/*
public class HtmlEntity:GLib{

public HtmlEntity(){

}

public static string Encode(){

}
public static string Decode(){

}

}
*/

//******************************************
//******************************************
[Description(nick = "HTTP Form", blurb = "")]
public class Form:GLib.Object{

public Form(){

}

[Description(nick = "Form Data Decode", blurb = "Get data From Form")]
public static HashMap<string, string> DataDecode(string? data){
//Intl.setlocale (LocaleCategory.ALL, "es_ES.UTF-8");

var Retorno = new HashMap<string, string>();
if(data != null){

// Con la cadena formada la dividimos en bloques de datos, seprarados por &
foreach(var Bloque in data.split("&")){
var KVx = Bloque.split("=");
if(KVx.length==2){
string Key = Uri.unescape_string(KVx[0].replace("+", " "));
string Value = Uri.unescape_string(KVx[1].replace("+", " "));
//print(">>>>>>>>>>>>>>>>>>>>> %s => %s\n", KVx[1], Value);
if(Retorno.has_key(Key)){
var Nombre = new StringBuilder();
int i = 0;
while(i<Retorno.size){
Nombre.truncate(0);
Nombre.append_printf("%s%i", Key, i);
if(!Retorno.has_key(Nombre.str)){
break;
}
i++;
}
Retorno[Nombre.str] = Value;
}else{
Retorno[Key] = Value;
}
}
}
}
//print("UriDecode: %s\n",  Retorno.str);
return Retorno;
}
}

//******************************************
//******************************************
[Description(nick = "HTTP Header", blurb = "HTTP Base Header")]
public class Header:GLib.Object{
public string CacheControl = ""; // General
public string Connection = ""; // General
public string ContentEncoding = ""; //Entity
public string ContentLenguaje = ""; //Entity
public int ContentLength = 0; //Entity
public string ContentLocation = ""; //Entity
public string ContentMD5 = ""; //Entity
public string ContentRange = ""; //Entity
public string ContentType = ""; //Entity
public string Date = ""; //General
public string Expires = ""; //Entity
public string LastModified = ""; //Entity
public string Pragma = ""; //General
public string Range = "";  //Entity
public string Trailer = ""; //Entity
public string TransferEncoding = ""; //General
public string Upgrade = ""; //General
public string Via = "";  //General
public string Warning = "";  //General
public string HttpVersion = "";

public Header(){

}

public virtual void print(){
stdout.printf("%s\n", this.ToString());
}

public virtual string ToString(){
var Cadena = new StringBuilder();
if(this.CacheControl.length > 0){
Cadena.append_printf("Cache-Control: %s\n", this.CacheControl);
}
if(this.Connection.length > 0){
Cadena.append_printf("Connection: %s\n", this.Connection);
}
if(this.ContentEncoding.length > 0){
Cadena.append_printf("Content-Encoding: %s\n", this.ContentEncoding);
}
if(this.ContentLenguaje.length > 0){
Cadena.append_printf("Content-Lenguaje: %s\n", this.ContentLenguaje);
}
if(this.ContentLength > 0){
Cadena.append_printf("Content-Length: %i\n", this.ContentLength);
}
if(this.ContentLocation.length > 0){
Cadena.append_printf("Content-Location: %s\n", this.ContentLocation);
}
if(this.ContentMD5.length > 0){
Cadena.append_printf("ContentMD5: %s\n", this.ContentMD5);
}
if(this.ContentRange.length > 0){
Cadena.append_printf("Content-Range: %s\n", this.ContentRange);
}
if(this.ContentType.length > 0){
Cadena.append_printf("Content-Type: %s\n", this.ContentType);
}
if(this.Date.length > 0){
Cadena.append_printf("Date: %s\n", this.Date);
}
if(this.Expires.length > 0){
Cadena.append_printf("Expires: %s\n", this.Expires);
}
if(this.LastModified.length > 0){
Cadena.append_printf("LastModified: %s\n", this.LastModified);
}
if(this.Pragma.length > 0){
Cadena.append_printf("Pragma: %s\n", this.Pragma);
}

if(this.Range.length > 0){
Cadena.append_printf("Range: %s\n", this.Range);
}
if(this.Trailer.length > 0){
Cadena.append_printf("Trailer: %s\n", this.Trailer);
}
if(this.TransferEncoding.length > 0){
Cadena.append_printf("Transfer-Encoding: %s\n", this.TransferEncoding);
}
if(this.Upgrade.length > 0){
Cadena.append_printf("Upgrade: %s\n", this.Upgrade);
}
if(this.Via.length > 0){
Cadena.append_printf("Via: %s\n", this.Via);
}
if(this.Warning.length > 0){
Cadena.append_printf("Warning: %s\n", this.Warning);
}
if(this.HttpVersion.length > 0){
Cadena.append_printf("Http-Version: %s\n", this.HttpVersion);
}
return Cadena.str;
}


}


[Description(nick = "HTTP Request Header", blurb = "")]
public class RequestHeader:Header{
public string Accept = "";
public string AcceptCharset = "";
public string AcceptEncoding = "";
public string AcceptLanguage = "";
public string Autorization = ""; 
public string Except = ""; 
public string From = "";
public string Host = "";
public string IfMatch = "";
public string IfModifiedSince = "";
public string IfNoneMatch = "";
public string IfRange = "";
public string IfUnmodifiedSince = "";
public string MaxFordwards = "";
public string ProxyAutorization = "";
public string Referer = "";
public string TE = "";
public string UserAgent = "";
public string Vary = "";

public RequestHeader(){

}

public override void print(){
stdout.printf("%s\n", this.ToString());
}                                                      

public override string ToString(){
var Cadena = new StringBuilder();
Cadena.append_printf("%s", base.ToString());

//base.print();
if(this.Accept.length > 0){
Cadena.append_printf("Accept: %s\n", this.Accept);
}
if(this.AcceptCharset.length > 0){
Cadena.append_printf("Accept-Charset: %s\n", this.AcceptCharset);
}
if(this.AcceptEncoding.length > 0){
Cadena.append_printf("Accept-Encoding: %s\n", this.AcceptEncoding);
}
if(this.AcceptLanguage.length > 0){
Cadena.append_printf("Accept-Language: %s\n", this.AcceptLanguage);
}
if(this.Autorization.length > 0){
Cadena.append_printf("Autorization: %s\n", this.Autorization);
}
if(this.Except.length > 0){
Cadena.append_printf("Except: %s\n", this.Except);
}
if(this.From.length > 0){
Cadena.append_printf("From: %s\n", this.From);
}
if(this.Host.length > 0){
Cadena.append_printf("Host: %s\n", this.Host);
}
if(this.IfMatch.length > 0){
Cadena.append_printf("IfMatch: %s\n", this.IfMatch);
}
if(this.IfModifiedSince.length > 0){
Cadena.append_printf("IfModifiedSince: %s\n", this.IfModifiedSince);
}
if(this.IfNoneMatch.length > 0){
Cadena.append_printf("IfNoneMatch: %s\n", this.IfNoneMatch);
}
if(this.IfRange.length > 0){
Cadena.append_printf("IfRange: %s\n", this.IfRange);
}
if(this.IfUnmodifiedSince.length > 0){
Cadena.append_printf("IfUnmodifiedSince: %s\n", this.IfUnmodifiedSince);
}
if(this.MaxFordwards.length > 0){
Cadena.append_printf("MaxFordwards: %s\n", this.MaxFordwards);
}
if(this.ProxyAutorization.length > 0){
Cadena.append_printf("Proxy-Autorization: %s\n", this.ProxyAutorization);
}
if(this.Referer.length > 0){
Cadena.append_printf("Referer: %s\n", this.Referer);
}
if(this.TE.length > 0){
Cadena.append_printf("TE: %s\n", this.TE);
}
if(this.UserAgent.length > 0){
Cadena.append_printf("User-Agent: %s\n", this.UserAgent);
}
if(this.Vary.length > 0){
Cadena.append_printf("Vary: %s\n", this.Vary);
}
return Cadena.str;
}

}


[Description(nick = "HTTP Response Header", blurb = "")]
public class ResponseHeader:Header{
public string AcceptRanges = "";
public string Age = "";
public string ETag = ""; 
public string Location = "";
public string ProxyAuthenticate = "";
public string RetryAfter = "";
public string Server = "";
public string WWWAuthenticate = "";
public StatusCode Status = StatusCode.NOT_IMPLEMENTED;

public ResponseHeader(){

}

public override string ToString(){
var Cadena = new StringBuilder();
Cadena.append_printf("%s", base.ToString());

if(this.AcceptRanges.length > 0){
Cadena.append_printf("Accept-Ranges: %s\n", this.AcceptRanges);
}
if(this.Age.length > 0){
Cadena.append_printf("Age: %s\n", this.Age);
}
if(this.ETag.length > 0){
Cadena.append_printf("ETag: %s\n", this.ETag);
}
if(this.Location.length > 0){
Cadena.append_printf("Location: %s\n", this.Location);
}
if(this.ProxyAuthenticate.length > 0){
Cadena.append_printf("Proxy-Authenticate: %s\n", this.ProxyAuthenticate);
}
if(this.RetryAfter.length > 0){
Cadena.append_printf("Retry-After: %s\n", this.RetryAfter);
}
if(this.Server.length > 0){
Cadena.append_printf("Server: %s\n", this.Server);
}
if(this.WWWAuthenticate.length > 0){
Cadena.append_printf("WWW-Authenticate: %s\n", this.WWWAuthenticate);
}

return Cadena.str;
}

public string StatusString(){
return HtmlStatusCode(this.Status);
}

[Description(nick = "enum StatusCode to HTTP Status", blurb = "")]  
public static string HtmlStatusCode(StatusCode sc){
string Retorno = "";
switch(sc){
	case 	StatusCode.NONE:
Retorno =  "";
break;
	case StatusCode.CONTINUE:
Retorno =  "HTTP/1.1 100 CONTINUE";
break;
	case 	StatusCode.SWITCHING_PROTOCOLS:
Retorno =  "HTTP/1.1 101 SWITCHING PROTOCOLS";
break;
	case StatusCode.OK:
Retorno =  "HTTP/1.1 200 OK";
break;
	case 	StatusCode.CREATED:
Retorno =  "HTTP/1.1 201 CREATED";
break;
	case	StatusCode.ACCEPTED:
Retorno =  "HTTP/1.1 202 ACCEPTED";
break;
	case	StatusCode.NON_AUTHORITATIVE:
Retorno =  "HTTP/1.1 203 NON AUTHORITATIVE INFORMATION";
break;
	case	StatusCode.NO_CONTENT:
Retorno =  "HTTP/1.1 204 NO CONTENT";
break;
	case	StatusCode.RESET_CONTENT:
Retorno =  "HTTP/1.1 205 RESET CONTENT";
break;
	case	StatusCode.PARTIAL_CONTENT:
Retorno =  "HTTP/1.1 206 PARTIAL CONTENT";
break;
	case	StatusCode.MULTIPLE_CHOICES:
Retorno =  "HTTP/1.1 300 MULTIPLE CHOICES";
break;
	case	StatusCode.MOVED_PERMANENTLY:
Retorno =  "HTTP/1.1 301 MOVED PERMANENTLY";
break;
	case	StatusCode.FOUND:
Retorno =  "HTTP/1.1 302 FOUND";
break;

	case	StatusCode.SEE_OTHER:
Retorno =  "HTTP/1.1 303 SEE OTHER";
break;
	case	StatusCode.NOT_MODIFIED:
Retorno =  "HTTP/1.1 304 NOT MODIFIED";
break;
	case	StatusCode.USE_PROXY:
Retorno =  "HTTP/1.1 305 USE PROXY";
break;
	case	StatusCode.TEMPORARY_REDIRECT:
Retorno =  "HTTP/1.1 307 TEMPORARY REDIRECT";
break;
	case	StatusCode.BAD_REQUEST:
Retorno =  "HTTP/1.1 400 BAD REQUEST";
break;
	case	StatusCode.UNAUTHORIZED:
Retorno =  "HTTP/1.1 401 UNAUTHORIZED";
break;
	case	StatusCode.PAYMENT_REQUIRED:
Retorno =  "HTTP/1.1 402 UNAUTHORIZED";
break;
	case	StatusCode.FORBIDDEN:
Retorno =  "HTTP/1.1 403 FORBIDDEN";
break;
	case	StatusCode.NOT_FOUND:
Retorno =  "HTTP/1.1 404 NOT FOUND";
break;
	case	StatusCode.METHOD_NOT_ALLOWED:
Retorno =  "HTTP/1.1 405 METHOD NOT ALLOWED";
break;
	case	StatusCode.NOT_ACCEPTABLE:
Retorno =  "HTTP/1.1 406 NOT ACCEPTABLE";
break;
	case	StatusCode.PROXY_AUTHENTICATION_REQUIRED:
Retorno =  "HTTP/1.1 407 PROXY AUTHENTICATION REQUIRED";
break;
	case	StatusCode.REQUEST_TIMEOUT:
Retorno =  "HTTP/1.1 408 REQUEST TIMEOUT";
break;

	case	StatusCode.CONFLICT:
Retorno =  "HTTP/1.1 409 CONFLICT";
break;
	case	StatusCode.GONE:
Retorno =  "HTTP/1.1 410 GONE";
break;
	case	StatusCode.LENGTH_REQUIRED:
Retorno =  "HTTP/1.1 411 LENGTH REQUIRED";
break;

	case	StatusCode.PRECONDITION_FAILED:
Retorno =  "HTTP/1.1 412 PRECONDITION FAILED";
break;
	case	StatusCode.REQUEST_ENTITY_TOO_LARGE:
Retorno =  "HTTP/1.1 413 REQUEST ENTITY TOO LARGE";
break;
	case	StatusCode.REQUEST_URI_TOO_LONG:
Retorno =  "HTTP/1.1 414 REQUEST URI TOO LONG";
break;
	case	StatusCode.UNSUPPORTED_MEDIA_TYPE:
Retorno =  "HTTP/1.1 415 UNSUPPORTED MEDIA TYPE";
break;
	case	StatusCode.REQUESTED_RANGE_NOT_SATISFIABLE:
Retorno =  "HTTP/1.1 416 REQUESTED RANGE NOT SATISFIABLE";
break;
	case	StatusCode.EXPECTATION_FAILED:
Retorno =  "HTTP/1.1 417 EXPECTATION FAILED";
break;
	case	StatusCode.INTERNAL_SERVER_ERROR:
Retorno =  "HTTP/1.1 500 INTERNAL SERVER ERROR";
break;
	case	StatusCode.NOT_IMPLEMENTED:
Retorno =  "HTTP/1.1 501 NOT IMPLEMENTED";
break;
	case	StatusCode.BAD_GATEWAY:
Retorno =  "HTTP/1.1 502 BAD GATEWAY";
break;
	case	StatusCode.SERVICE_UNAVAILABLE:
Retorno =  "HTTP/1.1 503 SERVICE UNAVAILABLE";
break;
	case	StatusCode.GATEWAY_TIMEOUT:
Retorno =  "HTTP/1.1 504 GATEWAY TIMEOUT";
break;
	case	StatusCode.HTTP_VERSION_NOT_SUPPORTED:
Retorno =  "HTTP/1.1 505 HTTP VERSION NOT SUPPORTED";
break;
}

return Retorno;
}

}

[Description(nick = "HTTP Request", blurb = "")]
public class Request:GLib.Object {
public RequestMethod Method = RequestMethod.UNKNOW;
public  string Path = "";
[Description(nick = "Query", blurb = "Query pased by url, Method GET")]
public  HashMap<string, string> Query = new HashMap<string, string>();
public RequestHeader Header = new RequestHeader();
[Description(nick = "Content data", blurb = "Content sent by User Agent")]
private uint8[] DatasInternal =  new uint8[0];
[Description(nick = "Content Form", blurb = "Content sent by User Agent from POST")]
public HashMap<string, string> Form {get; private set; default = new HashMap<string, string>();}

public Request(){

}

//public string 

public void print(){
stdout.printf("Request\n");
stdout.printf("Path: %s\n", Path);
Header.print();
stdout.printf("\nQuery:\n");
foreach(var q in Query.entries){
stdout.printf("%s: %s\n", q.key, q.value);
}
stdout.printf("\nForm:\n");
foreach(var f in Form.entries){
stdout.printf("%s: %s\n", f.key, f.value);
}

}

public uint8[] Data{
get{
return DatasInternal;
}

set{
DatasInternal = value;
Form.clear();
if(DatasInternal!=null && this.Header.ContentLength>0){

string Cadena = (string)Data;
var CadenaTempo = new StringBuilder();
// Formamos una cadena solo con los caracteres validos
unichar caracter;
for(int i = 0; Cadena.get_next_char(ref i, out caracter);){

if(i>this.Header.ContentLength){
break;
}
if((caracter.type() != UnicodeType.UNASSIGNED) && (caracter.type() != UnicodeType.CONTROL) && caracter.validate()){
CadenaTempo.append_unichar(caracter);
}else{
break;
}
}
Form = uHttp.Form.DataDecode(CadenaTempo.str);
}
}

}


}

[Description(nick = "HTTP Response", blurb = "Response from server")]
public class Response:GLib.Object {
public  uint8[] Data = new uint8[0];
public ResponseHeader Header = new ResponseHeader();
public Response(){
Header.Server = VERSION;
Header.ContentType = "text/html";
}

public string ToString(){
var Cadena = new StringBuilder();
Cadena.append_printf("%s\n", this.Header.StatusString());
Cadena.append_printf("%s", this.Header.ToString());
return Cadena.str;
}

}

[Description(nick = "HTTP Server Config", blurb = "Micro embebed HTTP Web Server config file")]
public class uHttpServerCongif:GLib.Object {

[Description(nick = "Signal on write file", blurb = "")]
public signal void FileWrited();

[Description(nick = "Port", blurb = "Default: 8080")]
public uint16 Port = 8080;

[Description(nick = "Index", blurb = "Index page, default: index.html")]
public string Index = "index.html";

public bool RequestPrintOnConsole = false;

[Description(nick = "Virtual Url", blurb = "List of Virtual URL (para ser manejado por el usuario)")]
public HashMap<string, string> VirtualUrl = new HashMap<string, string>();
[Description(nick = "Path Root", blurb = "Default: rootweb on current directory.")]
	public string Root = "*uhttproot";

public uHttpServerCongif(){
try{
        // Reference a local file name
        var file = File.new_for_path ("uhttp.conf");
{

            // Test for the existence of file
            if (file.query_exists ()) {
this.read();
            }else{
this.save("");
this.write();
}


}

}catch(GLib.Error e){
		stdout.printf ("cError: %s\n", e.message);
}
}

public void read(){

try{

	KeyFile file = new KeyFile ();

	file.load_from_file ("uhttp.conf", KeyFileFlags.NONE);

	this.Port = (uint16)file.get_uint64 ("uHTTP", "Port");
	this.Index = file.get_string ("uHTTP", "Index");


	if(file.get_string ("uHTTP", "Root").length == 0){
	this.Root = Path.build_path (Path.DIR_SEPARATOR_S, Environment.get_current_dir (), "uhttproot");
}else if(file.get_string ("uHTTP", "Root").has_prefix("*")){
this.Root = Path.build_path (Path.DIR_SEPARATOR_S, Environment.get_current_dir (), file.get_string ("uHTTP", "Root").replace("*", ""));
}else{
	this.Root = file.get_string ("uHTTP", "Root");

}


	this.RequestPrintOnConsole = file.get_boolean ("uHTTP", "RequestPrintOnConsole");


} catch (KeyFileError e) {
		stdout.printf ("rError: %s\n", e.message);
//this.write();
	}
catch (GLib.FileError fe) {
		stdout.printf ("rError: %s\n", fe.message);
this.write();
	}


}


private void save (string datakf){
try{
        // Reference a local file name
        var file = File.new_for_path ("uhttp.conf");
{

            // Test for the existence of file
            if (file.query_exists ()) {
file.delete();
            }
        var dos = new DataOutputStream (file.create (FileCreateFlags.REPLACE_DESTINATION));
     
        // For long string writes, a loop should be used, because sometimes not all data can be written in one run
        // 'written' is used to check how much of the string has already been written
        uint8[] data = datakf.data;
        long written = 0;
        while (written < data.length) { 
            // sum of the bytes of 'text' that already have been written to the stream
            written += dos.write (data[written:data.length]);
        }
FileWrited();


}

}catch(GLib.Error e){
		stdout.printf ("Error: %s\n", e.message);
}
}

public string ToXml(bool fieldtextasbase64 = true){
string Retorno = "";
var TempS = new StringBuilder("<uhttp>");

this.read();

if(fieldtextasbase64){
TempS.append_printf("<row><index>%s</index><port>%s</port><root>%s</root><RequestPrintOnConsole>%s</RequestPrintOnConsole></row>", Base64.encode(this.Index.data), Base64.encode(this.Port.to_string().data), Base64.encode(this.Root.data), Base64.encode(this.RequestPrintOnConsole.to_string().data));
}else{
TempS.append_printf("<row><index>%s</index><port>%s</port><root>%s</root><RequestPrintOnConsole>%s</RequestPrintOnConsole></row>", this.Index, this.Port.to_string(), this.Root, this.RequestPrintOnConsole.to_string());
}


TempS.append("</uhttp>");
Retorno = TempS.str;

return Retorno;
}


public bool write(){
bool Retorno = false;
string _rootpath = "";
if(this.Root.length < 1){
_rootpath = Path.build_path (Path.DIR_SEPARATOR_S, Environment.get_current_dir (), "uhttproot");
}else{
_rootpath = this.Root;
}

try{


	KeyFile filekf = new KeyFile ();

	filekf.load_from_file ("uhttp.conf", KeyFileFlags.NONE);

	filekf.set_string("uHTTP", "Port", this.Port.to_string());
	filekf.set_comment("uHTTP", "Port", "Puerto / Socket, default: 8080");

	filekf.set_string("uHTTP", "Index", this.Index);
	filekf.set_comment("uHTTP", "Index", "Página de inicio, default: index.html");

	filekf.set_string("uHTTP", "Root", _rootpath);
	filekf.set_comment("uHTTP", "Root", "Carpeta raíz de los documentos del servidor web. La ruta puede ser absoluta, o si la ruta inicia con * se tomará como relativa a la ubicación donde está corriendo el servidor. Si se deja vacio se tomará como raiz una cartepa llamada uhttproot dentro de la ubicación actual del servidor.");

	filekf.set_boolean("uHTTP", "RequestPrintOnConsole", this.RequestPrintOnConsole);
	filekf.set_comment("uHTTP", "RequestPrintOnConsole", "Imprime en consola las peticiones realizadas al servidor");

this.save(filekf.to_data());
   
Retorno = true;

	} catch (KeyFileError e) {
		stdout.printf ("wError: %s\n", e.message);
	}
catch (GLib.FileError fe) {
		stdout.printf ("wError: %s\n", fe.message);
this.save("");
	}

return Retorno;
}

}


[Description(nick = "HTTP Server", blurb = "Micro embebed HTTP Web Server")]
public class uHttpServer:GLib.Object {

[Description(nick = "Signal Request Virtual URL", blurb = "")]
public signal void RequestVirtualUrl(Request request, DataOutputStream dos);

  private ThreadedSocketService tss;

[Description(nick = "Config uHTTP", blurb = " Data Config uHTTP")]
public uHttpServerCongif Config = new uHttpServerCongif();

[Description(nick = "Virtual Url", blurb = "List of Virtual URL (para ser manejado por el usuario)")]
public HashMap<string, string> VirtualUrl = new HashMap<string, string>();

[Description(nick = "Constructor uHttpServer", blurb = "")]  
  public uHttpServer(int max_threads = 100) {
    //make the threaded socket service with hella possible threads
    tss = new ThreadedSocketService(max_threads);
    /* connect the 'run' signal that is emitted when 
     * there is a connection to our connection handler
     */

//VirtualUrl["uhttp_joinjsfiles"] = "/uhttp_joinjsfiles.js";

    tss.run.connect( connection_handler );
  }
  
[Description(nick = "Run Server", blurb = "Run on MainLoop")]  
  public void run() {
    //create an IPV4 InetAddress bound to no specific IP address
    InetAddress ia = new InetAddress.any(SocketFamily.IPV4);
    //create a socket address based on the netadress and set the port
    InetSocketAddress isa = new InetSocketAddress(ia, Config.Port);
    //try to add the address to the ThreadedSocketService
    try {
      tss.add_address(isa, SocketType.STREAM, SocketProtocol.TCP, null, null);
    } catch(Error e) {
      stderr.printf(e.message+"\n");
      return;
    }
    //we need a gobject main loop
    MainLoop ml = new MainLoop();
    //start listening 
    tss.start();
    stdout.printf("Serving on port %s\n", Config.Port.to_string());
//tss.
    //run the main loop
    ml.run();
  }

public void run_without_mainloop(){
    //create an IPV4 InetAddress bound to no specific IP address
    InetAddress ia = new InetAddress.any(SocketFamily.IPV4);
    //create a socket address based on the netadress and set the port
    InetSocketAddress isa = new InetSocketAddress(ia, Config.Port);
    //try to add the address to the ThreadedSocketService
    try {
      tss.add_address(isa, SocketType.STREAM, SocketProtocol.TCP, null, null);
    } catch(Error e) {
      stderr.printf(e.message+"\n");
      return;
    }
    //we need a gobject main loop
//    MainLoop ml = new MainLoop();
    //start listening 
    tss.start();
    stdout.printf("Serving on port %s\n", Config.Port.to_string());
//tss.
    //run the main loop
  //  ml.run();
}

[Description(nick = "GenUrl", blurb = "Crea una Url unica automaticamente")]  
public static string GenUrl(string root = "/", string value = "Sf54+-dsfk%6md&bfpJ"){
TimeVal tv = TimeVal();
tv.get_current_time();
return root+Checksum.compute_for_string(ChecksumType.MD5, value+"-"+tv.to_iso8601 ())+Checksum.compute_for_string(ChecksumType.MD5, root);
}

//**************************************************************
  //when a request is made, handle the socket connection
  private bool connection_handler(SocketConnection connection) {

    size_t size = 0;
    Request request = new Request();

    //get data input and output streams for the connection
    DataInputStream dis = new DataInputStream(connection.input_stream);
    DataOutputStream dos = new DataOutputStream(connection.output_stream);  

    try {

    string firstblock ="";

var PrimerBloque = new StringBuilder();

int maxline = 100;
while(maxline>0){
firstblock = dis.read_line( out size );
if(firstblock != null){
PrimerBloque.append(firstblock);
}
if(firstblock=="\r" || firstblock == null){
break;
}
maxline--;
}
request = DecodeRequest(PrimerBloque.str);
PrimerBloque.truncate();

if(request.Header.ContentLength>0){
uint8[] datos = new uint8[request.Header.ContentLength];
dis.read (datos);
request.Data = datos;
}

if(Config.RequestPrintOnConsole){
request.print();
}
      
    } catch (Error e) {
warning(e.message+"\n");
    }

if(!VirtualUrl.values.contains(request.Path)){

    Response response = new Response();

if(request.Path == "/"){
print("Llama al Doc Raiz\n");
        response.Header.Status = StatusCode.OK;
    response.Data = LoadFile(PathLocalFile(Config.Index));
    response.Header.ContentType = "text/html";
    serve_response( response, dos );


}else if(request.Path  == "/virtualurls.uhttp"){
// Devuelva una lista en xml de todas las paginas virtuales del sistema

        response.Header.Status = StatusCode.OK;
    response.Data = LoadFile(this.VirtualUrlsToXml());
    response.Header.ContentType = "text/xml";
    serve_response( response, dos );

}else if(request.Path  == "/config.uhttp"){
// Devuelva una lista en xml de todas las paginas virtuales del sistema

        response.Header.Status = StatusCode.OK;
    response.Data = LoadFile(Config.ToXml());
    response.Header.ContentType = "text/xml";
    serve_response( response, dos );

}else if(request.Path  == "/joinjsfiles.uhttp"){
// Esta seccion es una utilidad del servidor que permite unir varios archivos javascript en uno solo y enviarlo a cliente, esto elimina la cantidad de peticiones hechas al servidor y carga mas rapido la pagina. 
// Los scripts separados por comas, sin el .js y el path relativo o absoluto
// Recordar que es una peticion GET por lo que el limite del string 
// el formato de envio es /joinjsfiles.uhttp?files=/script1,/script2,/script3
var textjoin = new StringBuilder();
var pathjs = new StringBuilder();
        response.Header.Status = StatusCode.OK;
    response.Header.ContentType = "application/javascript";

if(request.Query.has_key("files")){

foreach(var p in request.Query["files"].split(",")){
pathjs.truncate();
pathjs.append_printf("%s.js", PathLocalFile(p));
if(FileUtils.test(pathjs.str, GLib.FileTest.IS_REGULAR)){
textjoin.append_printf("%s ", ReadJavaScriptFile(pathjs.str));
}

}
}

    response.Data = textjoin.str.data;

    serve_response( response, dos );

}else if(FileUtils.test(PathLocalFile(request.Path), GLib.FileTest.IS_REGULAR)){
// Es un archivo local. Lo carga y lo envia al cliente
        response.Header.Status = StatusCode.OK;
    response.Data = LoadFile(PathLocalFile(request.Path));
    response.Header.ContentType = GetMimeTypeToFile(request.Path);
    serve_response( response, dos );

}else{
//print("No found\n");
     response.Header.Status = StatusCode.NOT_FOUND;
  response.Data = "NO FOUND PAGE".data;
  response.Header.ContentType = "text/html";
    serve_response( response, dos );
stderr.printf("Path no found: %s\n", request.Path);
}
}else{
RequestVirtualUrl(request, dos);
}

    return false;
  }


private string VirtualUrlsToXml(bool fieldtextasbase64 = true){

string Retorno = "";
var TempS = new StringBuilder("<uhttp>");
if(fieldtextasbase64){
TempS.append_printf("<row><name>%s</name><url>%s</url></row>", Base64.encode("joinjsfiles.uhttp".data), Base64.encode("/joinjsfiles.uhttp".data));
TempS.append_printf("<row><name>%s</name><url>%s</url></row>", Base64.encode("virtualurls.uhttp".data), Base64.encode("/virtualurls.uhttp".data));
}else{
TempS.append_printf("<row><name>%s</name><url>%s</url></row>", "joinjsfiles.uhttp", "/joinjsfiles.uhttp");
TempS.append_printf("<row><name>%s</name><url>%s</url></row>", "virtualurls.uhttp", "/virtualurls.uhttp");
}


foreach(var url in VirtualUrl.entries){
if(fieldtextasbase64){
TempS.append_printf("<row><name>%s</name><url>%s</url></row>", Base64.encode(url.key.data), Base64.encode(url.value.data));
}else{
TempS.append_printf("<row><name>%s</name><url>%s</url></row>", url.key, url.value);
}
}

TempS.append("</uhttp>");
Retorno = TempS.str;

return Retorno;
}


// Decodifica los datos provenientes de una requerimiento
private static Request DecodeRequest(string lines){
//print("<<<%s>>>\n", lines);
Request Retorno = new Request();
    try {
Regex regexbase = new Regex("""(?<key>[a-zA-Z\-]+): (?<value>[a-zA-Z0-9]+)""");

int i = 0;

foreach(var line in lines.split("\r")){
//print("%s\n", line);
if(i==0){

// Decodificamos la primera linea
if(line.has_prefix("GET")){
Retorno.Method   = RequestMethod.GET;
}else if(line.has_prefix("POST")){
Retorno.Method   = RequestMethod.POST;
}else if(line.has_prefix("HEAD")){
Retorno.Method   = RequestMethod.HEAD;
}
    //get the parts from the line
    string[] partsline = line.split(" ");

if(partsline.length==3){

var partsquery = partsline[1].split("?");

if(partsquery.length>0){
Retorno.Path = partsquery[0];

if(partsquery.length>1){
foreach(var part in partsquery[1].split("&")){
var kv = part.split("=");
if(kv.length>1){
string Key = Uri.unescape_string(kv[0].replace("+", " "));
string Value = Uri.unescape_string(kv[1].replace("+", " "));
Retorno.Query[Key] = Value;
//print("%s >>>>>>>>>>>>>>>>> %s\n", kv[1], Value);
//Retorno.Query[Uri.unescape_string(kv[0])] = Uri.unescape_string(kv[1]);
}

}
}

}

}
}else{
// Decodificamos el contenido del Header
MatchInfo match;
if(regexbase.match(line, RegexMatchFlags.ANCHORED, out match)){
//TODO// Completaar el resto de opciones
switch(match.fetch_named("key")){
case "Content-Length":
Retorno.Header.ContentLength = int.parse(match.fetch_named("value"));
break;
case "Host":
Retorno.Header.Host = match.fetch_named("value");
break;
case "User-Agent":
Retorno.Header.UserAgent = match.fetch_named("value");
break;
case "Accept":
Retorno.Header.Accept = match.fetch_named("value");
break;
case "Accept-Language":
Retorno.Header.AcceptLanguage = match.fetch_named("value");
break;
case "Accept-Encoding":
Retorno.Header.AcceptEncoding = match.fetch_named("value");
break;
case "Connection":
Retorno.Header.Connection = match.fetch_named("value");
break;
case "Accept-Charset":
Retorno.Header.AcceptCharset = match.fetch_named("value");
break;
case "Referer":
Retorno.Header.Referer = match.fetch_named("value");
break;
}

}

}
i++;
}


    } catch(Error e) {
      stderr.printf(e.message+"\n");
    }
return Retorno;
}





  //********************************************************************
[Description(nick = "Server Response", blurb = "")]  
  public void serve_response(Response response, DataOutputStream dos) {

var Temporizador = new Timer();
Temporizador.start();

    try {

var Encabezado = new StringBuilder();
Encabezado.append_printf("%s", response.ToString());
Encabezado.append("\n");//this is the end of the return headers

//print("Encabezado: %s\n", Encabezado.str);

// Enviamos los datos del enzabezado
      long writtenhead = 0;
      while (writtenhead < Encabezado.str.data.length) { 
          // sum of the bytes of 'text' that already have been written to the stream
          writtenhead += dos.write (Encabezado.str.data[writtenhead:Encabezado.str.data.length]);
      }

// Enviamos los datos
//written = 0;
   long written = 0;
if(response.Data.length>0){
      while (written < response.Data.length) { 
          // sum of the bytes of 'text' that already have been written to the stream
          written += dos.write (response.Data[written:response.Data.length]);
      }
}
//print("[Enviados: %fMB]\n", (float)(writtenhead+written)/1000000);
//dos.flush();
//response.dispose();
    } catch( Error e ) {
//      stderr.printf(e.message+"\n");
warning(e.message+"\n");
    }


if((Temporizador.elapsed()*1000)>2000){
stderr.printf("uHttpServer slow response\n");
}

Temporizador.stop();

  }



// Obtiene el path local del archivo solicitado
private string PathLocalFile(string Filex){
return Path.build_path (Path.DIR_SEPARATOR_S, Config.Root, Filex);
}

private static string ReadJavaScriptFile(string path){
return (string)LoadFile(path);
}

// Carga los datos de un archivo local
private static uint8[] LoadFile(string Path){
uint8[] buffer = new uint8[0];
if(Path.length>3){
try{
var file = File.new_for_path(Path);
var file_stream = file.read();
var data_stream = new DataInputStream (file_stream);
        data_stream.set_byte_order (DataStreamByteOrder.LITTLE_ENDIAN);
FileInfo inf = file.query_info("*", FileQueryInfoFlags.NONE);
var tama = inf.get_size();
//print(@"$Path => $tama\n");
 buffer = new uint8[tama];
data_stream.read(buffer);
}
catch(Error e){
GLib.warning ("[%s]\n%s\n", e.message, Path);
}
}
return buffer;
}
  // Define el MIME tpe segun la extension del archivo
private static string GetMimeTypeToFile(string path){

string Retorno = "text/plain";

string basen = Path.get_basename(path).reverse();
var exten = basen.split(".");
if(exten.length>0){
basen = exten[0].reverse();
//print("%s\n", basen);
switch(basen){
case "html":
Retorno = "text/html";
break;
case "htm":
Retorno = "text/html";
break;
case "xml":
Retorno = "text/xml";
break;
case "txt":
Retorno = "text/plain";
break;
//Imagenes
case "gif":
Retorno = "image/gif";
break;
case "jpeg":
Retorno = "image/jpeg";
break;
case "jpg":
Retorno = "image/jpeg";
break;
case "png":
Retorno = "image/png";
break;
case "swf":
Retorno = "application/x-shockwave-flash";
break;
case "psd":
Retorno = "image/psd";
break;
case "pdf":
Retorno = "application/pdf";
break;
case "bmp":
Retorno = "image/bmp";
break;
case "tiff":
Retorno = "image/tiff";
break;
case "jpc":
Retorno = "application/octet-stream";
break;
case "jp2":
Retorno = "image/jp2";
break;
case "jpx":
Retorno = "application/octet-stream";
break;
case "jb2":
Retorno = "application/octet-stream";
break;
case "swc":
Retorno = "application/x-shockwave-flash";
break;
case "iff":
Retorno = "image/iff";
break;
case "wbmp":
Retorno = "image/vnd.wap.wbmp";
break;
case "xbmp":
Retorno = "image/xbm";
break;
case "ico":
Retorno = "image/x-icon";
break;
case "svg":
Retorno = "image/svg+xml";
break;
case "js":
Retorno = "application/javascript";
break;
case "css":
Retorno = "text/css";
break;
case "gz":
Retorno = "application/x-compressed-tar";
break;
case "bz2":
Retorno = "application/x-bzip";
break;
default:
Retorno = "text/plain";
print(@"Mimetype Desconocido para [$basen] devuelve $Retorno [$path]\n");
break;
}
}

return Retorno;
}


}


}

