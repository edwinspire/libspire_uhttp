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

namespace edwinspire.uHttp{

const string VERSION = "uHttp Server Version 0.2 Alpha";

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

/*
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

*/

/*
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
*/

/*
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
*/
[Description(nick = "HTTP Request", blurb = "")]
public class Request:GLib.Object {
public RequestMethod Method {get; private set; default = RequestMethod.UNKNOW;}
public  string Path {get; private set; default = "";}
[Description(nick = "Query", blurb = "Query pased by url, Method GET")]
public  HashMap<string, string> Query {get; private set; default = new HashMap<string, string>();}
public HashMap<string, string> Header {get; private set; default = new HashMap<string, string>();}
//public RequestHeader Header = new RequestHeader();
[Description(nick = "Content data", blurb = "Content sent by User Agent")]
private uint8[] DatasInternal =  new uint8[0];
[Description(nick = "Content Form", blurb = "Content sent by User Agent from POST")]
public HashMap<string, string> Form {get; private set; default = new HashMap<string, string>();}
public bool isWebSocketHandshake {get; private set; default = false;}


public Request(){

}

// Decodifica los datos provenientes de una requerimiento
public void from_lines(string lines){
//print("<<<%s>>>\n", lines);
    try {
Regex regexbase = new Regex("""(?<key>[\w\-]+): (?<value>[\w|\W]+)""");

int i = 0;

foreach(var line in lines.split("\r")){
//print("%s\n", line);
if(i==0){

// Decodificamos la primera linea
if(line.has_prefix("GET")){
this.Method   = RequestMethod.GET;
}else if(line.has_prefix("POST")){
this.Method   = RequestMethod.POST;
}else if(line.has_prefix("HEAD")){
this.Method   = RequestMethod.HEAD;
}
    //get the parts from the line
    string[] partsline = line.split(" ");

if(partsline.length==3){

var partsquery = partsline[1].split("?");

if(partsquery.length>0){
this.Path = partsquery[0];

if(partsquery.length>1){
foreach(var part in partsquery[1].split("&")){
var kv = part.split("=");
if(kv.length>1){
string Key = Uri.unescape_string(kv[0].replace("+", " "));
string Value = Uri.unescape_string(kv[1].replace("+", " "));
this.Query[Key] = Value;
}

}
}

}

}
}else{
// Decodificamos el contenido del Header
MatchInfo match;
if(regexbase.match(line, RegexMatchFlags.ANCHORED, out match)){

this.Header[match.fetch_named("key")] = match.fetch_named("value");

}

}
i++;
}


    } catch(Error e) {
      stderr.printf(e.message+"\n");
    }

if(this.Header.has_key("Sec-WebSocket-Key")){
this.isWebSocketHandshake = true;
}

}

//public string 
public int ContentLength{
get{
//GLib.print("this.Header[Content-Length] = %s\n", this.Header["Content-Length"].to_string());
if(this.Header.has_key("Content-Length")){
return int.parse(this.Header["Content-Length"]);
}else{
return 0;
}
}
}


public void print(){
stdout.printf("<*** REQUEST ***>\n");
stdout.printf("<<isWebSocketHandshake>>: %s\n", this.isWebSocketHandshake.to_string());
stdout.printf("<<Method>>: %s\n", this.Method.to_string());
stdout.printf("<<Path>>: %s\n", Path);
stdout.printf("<<Header>>:\n%s\n", uHttpServerConfig.HashMapToString(this.Header));
stdout.printf("<<Query>>:\n%s\n", uHttpServerConfig.HashMapToString(this.Query));
stdout.printf("<<Form:>>\n%s\n", uHttpServerConfig.HashMapToString(this.Form));
}

public uint8[] Data{
get{
return DatasInternal;
}

set{
DatasInternal = value;
Form.clear();

int CLength = this.ContentLength;
if(DatasInternal!=null && CLength>0){

string Cadena = (string)Data;
var CadenaTempo = new StringBuilder();
// Formamos una cadena solo con los caracteres validos
unichar caracter;
for(int i = 0; Cadena.get_next_char(ref i, out caracter);){

if(i>CLength){
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
public StatusCode Status = StatusCode.NOT_IMPLEMENTED;
public HashMap<string, string> Header = new HashMap<string, string>();
public Response(){
Header["Server"] = VERSION;
Header["Content-Type"] = "text/html";
}

public string ToString(){
var Cadena = new StringBuilder();
Cadena.append_printf("%s", HtmlStatusCode(this.Status));

if(this.Header.has_key("Sec-WebSocket-Accept")){
Cadena.append("\r\n");//this is the end websocket
this.Header["Sec-WebSocket-Accept"] = this.CalcHandshake();
}else{
Cadena.append("\n");//this is the end of the return headers
}
Cadena.append_printf("%s\r", uHttpServerConfig.HashMapToString(this.Header));
return Cadena.str;
}

private string CalcHandshake(){
string Retorno = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";
if(this.Header.has_key("Sec-WebSocket-Key")){
Retorno = Base64.encode(Checksum.compute_for_string(ChecksumType.SHA1, Retorno+this.Header["Sec-WebSocket-Key"]).data);
}

return Retorno;
}


[Description(nick = "enum StatusCode to HTTP Status", blurb = "")]  
private static string HtmlStatusCode(StatusCode sc){
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


public static string HtmErrorPage(string title = "uHTTP WebServer", string error){

string Base = """<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>@Title</title>
</head>
<body  id="myapp">
 <div style="width: 100%; height: 100%;">
  <div style="border: 1px solid #423e3e; border-radius: 5px; -moz-border-radius: 5px; padding: 10px; -moz-box-shadow: 10px 10px 5px #000000; -webkit-box-shadow: 10px 10px 5px #000000; box-shadow: 10px 10px 5px #000000; clear: both; background-color: black; height: 150px; width: 550px; left: 50%; top: 50%; position: absolute; z-index: 900; margin-top: -150px; margin-left: -300px;">
  <img src="data:image/png;base64,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" style="margin: 5px; float: left;"></img>
    <div style="margin: 5px; font-family: Garamond, serif; line-height: 1em; color: #fa8c05; font-weight: bold; font-size: 40px; text-shadow: 0px 0px 0 rgb(226,116,-19),1px 1px 0 rgb(211,101,-34),2px 2px 0 rgb(197,87,-48),3px 3px 0 rgb(182,72,-63),4px 4px 0 rgb(168,58,-77),5px 5px 0 rgb(153,43,-92), 6px 6px 0 rgb(139,29,-106),7px 7px 6px rgba(0,0,0,0.6),7px 7px 1px rgba(0,0,0,0.5),0px 0px 6px rgba(0,0,0,.2); text-align: center;">
      @Error</div>
    <div style="color: white; position: relative; top: 80px; text-align: center;">
      uHTTP Micro WebServer - software@edwinspire.com</div>
  </div>
  </div>
</body>
</html>""";
string Retorno = Base.replace("@Title", title);
Retorno = Retorno.replace("@Error", error);
return Retorno;
}


}

[Description(nick = "HTTP Server Config", blurb = "Micro embebed HTTP Web Server config file")]
public class uHttpServerConfig:GLib.Object {

[Description(nick = "Signal on write file", blurb = "")]
public signal void FileWrited();

[Description(nick = "Port", blurb = "Default: 8080")]
public uint16 Port = 8080;

[Description(nick = "Index", blurb = "Index page, default: index.html")]
public string Index = "index.html";

public bool RequestPrintOnConsole = false;

[Description(nick = "Path Root", blurb = "Default: rootweb on current directory.")]
	public string Root = "*uhttproot";

public uHttpServerConfig(){
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

public static string HashMapToString(HashMap<string, string> hm){
var Retorno = new StringBuilder();
foreach(var r in hm.entries){
Retorno.append_printf("%s: %s\n", r.key, r.value);
}

return Retorno.str;
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

[Description(nick = "Signal Request URL No Found", blurb = "Señal se dispara cuando una página no es encontrada en el servidor")]
public signal void NoFoundURL(Request request);

  private ThreadedSocketService tss;

[Description(nick = "Config uHTTP", blurb = " Data Config uHTTP")]
public uHttpServerConfig Config = new uHttpServerConfig();

//[Description(nick = "Virtual Url", blurb = "List of Virtual URL (para ser manejado por el usuario)")]
//public HashMap<string, string> VirtualUrl = new HashMap<string, string>();

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

public static string EnumToXml(Type typeenum, bool fieldtextasbase64 = true){
var Retorno = new StringBuilder("<enum>");
var TempNick = new StringBuilder();

    EnumClass enum_class = (EnumClass) typeenum.class_ref ();
foreach(var item in enum_class.values){

TempNick.truncate();
if(item.value_nick.length>0){
TempNick.append(item.value_nick);
}else{
TempNick.append(item.value_name);
}

if(fieldtextasbase64){
Retorno.append_printf("<item><name>%s</name><value>%s</value></item>", Base64.encode(TempNick.str.data), item.value.to_string());
}else{
Retorno.append_printf("<item><name>%s</name><value>%s</value></item>", TempNick.str, item.value.to_string());
}

}

Retorno.append("</enum>");
return Retorno.str;
}
  
[Description(nick = "Run Server", blurb = "Run on MainLoop")]  
  public virtual void run() {
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

print("Start uHTTP Micro WebServer");
print("Licence: LGPL\n");
print("Contact: edwinspire@gmail.com\n");
print("Contact: software@edwinspire.com\n");
print("Contact: http://www.edwinspire.com\n\n");
print("Configure\n");
stdout.printf("Port: %s\n", Config.Port.to_string());
stdout.printf("Root: %s\n", Config.Root);
stdout.printf("Index: %s\n", Config.Index);
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

 public virtual bool connection_handler_virtual(Request request, DataOutputStream dos){

 uHttp.Response response = new uHttp.Response();
      response.Status = StatusCode.NOT_FOUND;
 response.Data = Response.HtmErrorPage("uHTTP WebServer", "404 - Página no encontrada").data;
  response.Header["Content-Type"] = "text/html";

this.serve_response( response, dos );

return false;
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
request.from_lines(PrimerBloque.str);
PrimerBloque.truncate();

if(request.ContentLength>0){
uint8[] datos = new uint8[request.ContentLength];
dis.read (datos);
request.Data = datos;
}

if(Config.RequestPrintOnConsole){
request.print();
}
      
    } catch (Error e) {
warning(e.message+"\n");
    }

    Response response = new Response();

if(request.Path == "/"){
print("Llama al Doc Raiz\n");
        response.Status = StatusCode.OK;
    response.Data = LoadFile(PathLocalFile(Config.Index));
    response.Header["Content-Type"] = "text/html";
    serve_response( response, dos );

}else if(request.Path  == "/config.uhttp"){
// Devuelva una lista en xml de la configuración del sistema

        response.Status = StatusCode.OK;
    response.Data = LoadFile(Config.ToXml());
    response.Header["Content-Type"] = "text/xml";
    serve_response( response, dos );

}else if(request.Path  == "/joinjsfiles.uhttp"){
// Esta seccion es una utilidad del servidor que permite unir varios archivos javascript en uno solo y enviarlo a cliente, esto elimina la cantidad de peticiones hechas al servidor y carga mas rapido la pagina. 
// Los scripts separados por comas, sin el .js y el path relativo o absoluto
// Recordar que es una peticion GET por lo que el limite del string 
// el formato de envio es /joinjsfiles.uhttp?files=/script1,/script2,/script3
var textjoin = new StringBuilder();
var pathjs = new StringBuilder();
        response.Status = StatusCode.OK;
    response.Header["Content-Type"] = "application/javascript";

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
        response.Status = StatusCode.OK;
    response.Data = LoadFile(PathLocalFile(request.Path));
    response.Header["Content-Type"] = GetMimeTypeToFile(request.Path);
    serve_response( response, dos );

}else if(request.Path == "/uhttp-websocket-echo.uhttp"){

if(request.isWebSocketHandshake){

/*
HTTP/1.1 101 Web Socket Protocol Handshake
Date: Thu, 11 Jul 2013 07:25:19 GMT
Server: Kaazing Gateway
Upgrade: WebSocket
Access-Control-Allow-Origin: http://www.websocket.org
Access-Control-Allow-Credentials: true
Sec-WebSocket-Accept: 0hUmf3igIrmXtazIXQYQC6XV0/8=
Connection: Upgrade
Access-Control-Allow-Headers: content-type
*/

        response.Status = StatusCode.SWITCHING_PROTOCOLS;
    response.Data = "".data;
    response.Header["Upgrade"] = "WebSocket";
    response.Header["Access-Control-Allow-Credentials"] = "yes";
    response.Header["Sec-WebSocket-Accept"] = "0hUmf3igIrmXtazIXQYQC6XV0/8=";
    response.Header["Connection"] = "Upgrade";
    response.Header["Access-Control-Allow-Headers"] = "content-type";
    serve_response( response, dos );


this.connection_handler_virtual(request, dos);
}


}else{

NoFoundURL(request);
//print("No found\n");
//     response.Header.Status = StatusCode.NOT_FOUND;
//  response.Data = Response.HtmErrorPage("uHTTP WebServer", "404 - Página no encontrada").data;
//  response.Header.ContentType = "text/html";
//    serve_response( response, dos );
// stderr.printf("Path no found: %s\n", request.Path);

// Si no se han encontrado el archivo dentro del servidor se buscará en las paginas virtuales. 
this.connection_handler_virtual(request, dos);
}

    return false;
  }

/*
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

*/





/*
// Decodifica los datos provenientes de una requerimiento
private static Request DecodeRequest_xxx(string lines){
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
*/




  //********************************************************************
[Description(nick = "Server Response", blurb = "")]  
  public void serve_response(Response response, DataOutputStream dos) {

var Temporizador = new Timer();
Temporizador.start();
/*
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
*/

var Encabezado = new StringBuilder();
Encabezado.append_printf("%s", response.ToString());
Encabezado.append("\n");//this is the end of the return headers

writeData(Encabezado.str.data, dos);
writeData(response.Data, dos);

if((Temporizador.elapsed()*1000)>2000){
stderr.printf("uHttpServer slow response\n");
}

Temporizador.stop();

  }


public long writeData(uint8[] data_, DataOutputStream dos){

   long written = 0;

try{
if(data_.length>0){
      while (written < data_.length) { 
          // sum of the bytes of 'text' that already have been written to the stream
          written += dos.write (data_[written:data_.length]);
      }
}
    } catch( Error e ) {
//      stderr.printf(e.message+"\n");
warning(e.message+"\n");
    }
return written;
}

// Obtiene el path local del archivo solicitado
public string PathLocalFile(string Filex){
return Path.build_path (Path.DIR_SEPARATOR_S, Config.Root, Filex);
}

public static string ReadFile(string path){
return (string)LoadFile(path);
}

private static string ReadJavaScriptFile(string path){
return ReadFile(path);
}

// Carga los datos de un archivo local
public static uint8[] LoadFile(string Path){
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
case "ogg":
Retorno = "application/ogg";
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

