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
namespace edwinspire.uHttp {
	const string VERSION = "uHttp Server Version 0.3 Alpha";
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
	public enum RequestMethod {
		UNKNOW,
		GET,
		POST,
		HEAD,
		PUT
	}
	//******************************************
	//******************************************
	/*[Description(nick = "HTTP Form", blurb = "")]
	public class Form:GLib.Object {
		public Form() {
		}
		[Description(nick = "Form Data Decode", blurb = "Get data From Form")]
		public static HashMap<string, string> DataDecode(string? data) {
			//Intl.setlocale (LocaleCategory.ALL, "es_ES.UTF-8");
			var Retorno = new HashMap<string, string>();
			if(data != null) {
				// Con la cadena formada la dividimos en bloques de datos, seprarados por &
				foreach(var Bloque in data.split("&")) {
					var KVx = Bloque.split("=");
					if(KVx.length==2) {
						string Key = Uri.unescape_string(KVx[0].replace("+", " "));
						string Value = Uri.unescape_string(KVx[1].replace("+", " "));
						//print(">>>>>>>>>>>>>>>>>>>>> %s => %s\n", KVx[1], Value);
						if(Retorno.has_key(Key)) {
							var Nombre = new StringBuilder();
							int i = 0;
							while(i<Retorno.size) {
								Nombre.truncate(0);
								Nombre.append_printf("%s%i", Key, i);
								if(!Retorno.has_key(Nombre.str)) {
									break;
								}
								i++;
							}
							Retorno[Nombre.str] = Value;
						} else {
							Retorno[Key] = Value;
						}
					}
				}
			}
			//print("UriDecode: %s\n",  Retorno.str);
			return Retorno;
		}
	}
	*/
	[Description(nick = "HTTP Request", blurb = "")]
	public class Request:GLib.Object {
		public RequestMethod Method {
			get;
			private set;
			default = RequestMethod.UNKNOW;
		}
		public  string Path {
			get;
			private set;
			default = "";
		}
		
		public  string url_query {
			get;
			private set;
			default = "";
		}
				
		public FormRequest Form = new FormRequest();
		/*
		[Description(nick = "Query", blurb = "Query pased by url, Method GET")]
		public  HashMap<string, string> Query {
			get;
			private set;
			default = new HashMap<string, string>();
		}*/
		public HashMap<string, string> Header {
			get;
			private set;
			default = new HashMap<string, string>();
		}
		//public RequestHeader Header = new RequestHeader();
		[Description(nick = "Content data", blurb = "Content sent by User Agent")]
		private uint8[] DatasInternal =  new uint8[0];
		/*[Description(nick = "Content Form", blurb = "Content sent by User Agent from POST")]
		public HashMap<string, string> Form {
			get;
			private set;
			default = new HashMap<string, string>();
		}*/
		public bool isWebSocketHandshake {
			get;
			private set;
			default = false;
		}/*
		public MultiPartFormData MultiPartForm {
			public get;
			private set;
			default = new MultiPartFormData();
		}*/
		public Request() {
		}
		// Decodifica los datos provenientes de un requerimiento
		public void from_lines(string lines) {
			//GLib.print("%s\n", lines);
			try {
				Regex regexbase = new Regex("""(?<key>[\w\-]+): (?<value>[\w|\W]+)""");
				int i = 0;
				foreach(var line in lines.split("\r")) {
					if(i==0) {
						// GLib.print("%s\n", line);
						// Decodificamos la primera linea
						if(line.has_prefix("GET")) {
							this.Method   = RequestMethod.GET;
						} else if(line.has_prefix("POST")) {
							this.Method   = RequestMethod.POST;
						} else if(line.has_prefix("HEAD")) {
							this.Method   = RequestMethod.HEAD;
						} else if(line.has_prefix("PUT")) {
							this.Method   = RequestMethod.PUT;
						}
						
						//get the parts from the line
						string[] partsline = line.split(" ");
						if(partsline.length==3) {
							var partsquery = partsline[1].split("?");
							if(partsquery.length>0) {
								this.Path = partsquery[0];
								if(partsquery.length>1) {
			//TODO Dejar solo FR ya que el resto se mantiene temporalmete solo por compatibilidad con la version anterior de la libreria.
								//	
								this.url_query = partsquery[1];
									/*foreach(var part in partsquery[1].split("&")) {
										var kv = part.split("=");
										if(kv.length>1) {
											string Key = Uri.unescape_string(kv[0].replace("+", " "));
											string Value = Uri.unescape_string(kv[1].replace("+", " "));
											this.Query[Key] = Value;
										}
									}*/
								}
							}
						}
					} else {
						// Decodificamos el contenido del Header
						MatchInfo match;
						if(regexbase.match(line, RegexMatchFlags.ANCHORED, out match)) {
							this.Header[match.fetch_named("key")] = match.fetch_named("value");
						}
					}
					i++;
				}
			}
			catch(Error e) {
				stderr.printf(e.message+"\n");
			}
			if(this.Header.has_key("Sec-WebSocket-Key")) {
				this.isWebSocketHandshake = true;
			}
		}
		//public string 
		public int ContentLength {
			get {
				//GLib.print("this.Header[Content-Length] = %s\n", this.Header["Content-Length"].to_string());
				if(this.Header.has_key("Content-Length")) {
					return int.parse(this.Header["Content-Length"]);
				} else {
					return 0;
				}
			}
		}
		public void print() {
			stdout.printf("<*** REQUEST ***>\n");
			stdout.printf("<<isWebSocketHandshake>>: %s\n", this.isWebSocketHandshake.to_string());
			stdout.printf("<<Method>>: %s\n", this.Method.to_string());
			stdout.printf("<<Path>>: %s\n", Path);
			stdout.printf("<<Header>>:\n%s\n", KeyValueFile.HashMapToString(this.Header));
			//stdout.printf("<<Boundary>>:\n%s\n", this.boundary);
			//stdout.printf("<<Query>>:\n%s\n", uHttpServerConfig.HashMapToString(this.Query));
			//stdout.printf("<<Form:>>\n%s\n", uHttpServerConfig.HashMapToString(this.Form));
			stdout.printf("<<MultiPartForm>>:\n");
			/*stdout.printf("[Is Multipart]: %s\n", this.MultiPartForm.is_multipart_form_data.to_string());
			if(this.MultiPartForm.is_multipart_form_data) {
				foreach(var r in this.MultiPartForm.Parts) {
					stdout.printf("[Headers]:\n");
					foreach(var v in r.Headers) {
						stdout.printf("%s: %s\n", v.name, v.value);
						if(v.param.size > 0) {
							stdout.printf("[Parametros]\n%s\n", uHttpServerConfig.HashMapToString(v.param));
						}
					}
					if(r.data.length > 1024) {
						stdout.printf("[Data (%s bytes)]\nData > 1024 bytes, no show!\n", r.data.length.to_string());
					} else {
						stdout.printf("[Data (%s bytes)]\n%s\n", r.data.length.to_string(), r.get_data_as_string_valid_unichars());
					}
				}
			}
			*/
			
			stdout.printf("Data FR \n%s\n", Form.to_string());
			
			
		}
		public uint8[] Data {
			get {
				return DatasInternal;
			}
			set {
				DatasInternal = value;
				/*//Form.clear();
				//stdout.printf("Data leng: %s\n", value.length.to_string());
				if(this.Method == RequestMethod.POST) {
					if(Header.has_key("Content-Type")) {
						if(Header["Content-Type"].has_prefix("multipart/form-data")) {
							MultiPartForm.decode(Header["Content-Type"], value);
						}
					}
				}
				if(!MultiPartForm.is_multipart_form_data) {
					int CLength = this.ContentLength;
					if(DatasInternal!=null && CLength>0) {
						Form = uHttp.Form.DataDecode(uHttpServer.get_data_as_string_valid_unichars(Data));
					}
				}*/
				
			this.Form.decode(this.Method, this.Header, this.url_query, this.DatasInternal);					
			}
		}
	}
	
	
	public class MultiPartFormDataHeader:GLib.Object {
		public string name {
			set;
			get;
			default = "";
		}
		public string value {
			set;
			get;
			default = "";
		}
		public HashMap<string, string> param {
			get;
			set;
			default = new HashMap<string, string>();
		}
		public MultiPartFormDataHeader() {
		}
		public string get_param_for_name(string name) {
			string Retorno = "";
			if(this.param.has_key(name)) {
				Retorno = this.param[name];
			}
			return Retorno;
		}
	}
	public class MultiPartFormDataPart:GLib.Object {
		public ArrayList<MultiPartFormDataHeader> Headers {
			get;
			set;
			default = new ArrayList<MultiPartFormDataHeader>();
		}
		private uint8[] _data = {
		}
		;
		private string _md5 = "";
		public MultiPartFormDataPart() {
		}
		public uint8[] data {
			get {
				return this._data;
			}
			set {
				this._data = value;
				this._md5 = Checksum.compute_for_data (ChecksumType.MD5, this._data);
			}
		}
		public string get_head_param(string head, string name) {
			string Retorno = "";
			this.get_header_for_name(head).get_param_for_name(name);
			return Retorno;
		}
		public MultiPartFormDataHeader get_header_content_disposition() {
			return this.get_header_for_name("Content-Disposition");
		}
		public string get_content_disposition_param(string name) {
			return this.get_header_content_disposition().get_param_for_name(name);
		}
		public MultiPartFormDataHeader get_header_for_name(string name) {
			var H = new MultiPartFormDataHeader();
			foreach(var h in this.Headers) {
				if(h.name == name) {
					H = h;
					break;
				}
			}
			return H;
		}
		public string get_data_as_string_valid_unichars() {
			return uHttpServer.get_data_as_string_valid_unichars(this.data);
		}
		public string compute_md5_for_data() {
			//return Checksum.compute_for_data (ChecksumType.MD5, this.data);
			return this._md5;
		}
	}
	public class MultiPartFormData:GLib.Object {
		private HashMap<int, MultiPartFormDataPart> PartsInternal = new HashMap<int, MultiPartFormDataPart>();
		public ArrayList<MultiPartFormDataPart> Parts {
			get;
			private set;
			default = new ArrayList<MultiPartFormDataPart>();
		}
		[Description(nick = "Multi Part Form Boundary", blurb = "Boundary")]
		public string boundary {
			get;
			private set;
			default = "uHTTPServerxyzqwertyuiopasdf2f3g5h5j";
		}
		public bool is_multipart_form_data {
			get;
			private set;
			default = false;
		}
		public MultiPartFormData() {
		}
		public void decode(string ContentTypeHeader, uint8[] d) {
			// Chequeamos si el Content-Type es multipart/form-data y extraemos el boundary
			try {
				Regex regexbase2 = new Regex("""multipart/form-data; boundary=(?<value>[-|\w|\W]+)""");
				MatchInfo match2;
				if(regexbase2.match(ContentTypeHeader, RegexMatchFlags.ANCHORED, out match2)) {
					if(match2.fetch_named("value") != null) {
						this.boundary = match2.fetch_named("value");
						this.is_multipart_form_data = true;
					}
				}
			}
			catch(Error e) {
				stderr.printf(e.message+"\n");
			}
			// Si es multipart entonces obtenemos las partes individuales
			if(this.is_multipart_form_data) {
				//stdout.printf("\n%s\n", (string)d);
				//string nameHeader = "";
				//string valueHeader = "";
				StringBuilder temp = new StringBuilder();
				//bool start = false;
				var e= new ArrayList<uint8>();
				int i = 0;
				int j = 0;
				int block = 0;
				bool header = false;
				bool data = false;
				try {
					Regex RxHeader = new Regex("""(?<header>[\w+\-]+): (?<value>[\w\-\/]+)""");
					Regex RxHeaderWparam = new Regex("""(?<header>[\w+\-]+): (?<value>[\w\-\/]+);(?<parameters>[\d\D]+)""");
					Regex RxHeaderParameter = new Regex("""\s?(?<name>[\w+\-]+)="(?<value>[ \s\w\W\d\D]+)"""+"\"");
					foreach(var x in d) {
						unichar uc = x;
						if(uc.validate() && !uc.iscntrl()) {
							temp.append_unichar(uc);
							//temp2.append_unichar(x);
						}
						if(block > 0 && data && j > 0) {
							e.add(x);
						}
						if( i > 0 && x == '\n' && d[i-1] == '\r') {
							//lastSalto = i-1;
							if(temp.str.has_suffix(this.boundary)) {
								//temp.truncate(0);
								if(block>0 && data && j > 0) {
									this.PartsInternal[block].data = e.slice(0, e.size-this.boundary.data.length-6).to_array();
									e.clear();
								}
								temp.truncate(0);
								block++;
								//stdout.printf("\n***INICIA [%i]***\n", block);
								header = false;
								data = false;
								j = 0;
								this.PartsInternal[block] = new MultiPartFormDataPart();
							}
							if(block>0 && !header && !data && temp.str == "") {
								//stdout.printf("\n***HEADERS***\n");
								header = true;
								j = 0;
								data = false;
								//stdout.printf("\n[%s](%i)\n", temp.str, block);
								temp.truncate(0);
							} else if(block > 0 && header && !data && temp.str == "") {
								//stdout.printf("\n***DATOS***\n");
								data = true;
								header = false;
								temp.truncate(0);
								j = i;
								//stdout.printf("\n[%s](%i)\n", i, block);
							} else if(block > 0 && !header && data && temp.str == "") {
								//stdout.printf("\n***FIN***\n");
								data = false;
								header = false;
								temp.truncate(0);
							} else if(block > 0 && header) {
								var h = new MultiPartFormDataHeader();
								//stdout.printf("\n[%s](%i)\n", temp.str, block);
								MatchInfo matchH;
								if(RxHeaderWparam.match(temp.str, RegexMatchFlags.ANCHORED, out matchH)) {
									// Con parametros
									h.name = matchH.fetch_named("header");
									h.value = matchH.fetch_named("value");
									this.PartsInternal[block].Headers.add(h);
									//stdout.printf("\n*[%s][%s][%s]*\n", h.name, h.value, matchH.fetch_named("parameters"));
									var ps = matchH.fetch_named("parameters").split(";");
									MatchInfo matchP;
									foreach(var p in ps) {
										//stdout.printf("\nParametros linea: %s\n", p);
										if(RxHeaderParameter.match(p, RegexMatchFlags.ANCHORED, out matchP)) {
											// Parametros
											h.param[matchP.fetch_named("name")] = matchP.fetch_named("value");
											//stdout.printf("\n*[%s]*=[%s]\n", matchP.fetch_named("name"), matchP.fetch_named("value"));
										}
									}
								} else if(RxHeader.match(temp.str, RegexMatchFlags.ANCHORED, out matchH)) {
									// Sin parametros
									h.name = matchH.fetch_named("header");
									h.value = matchH.fetch_named("value");
									//h.
									this.PartsInternal[block].Headers.add(h);
									//stdout.printf("\n[%s][%s]\n", h.name, h.value);
								}
								temp.truncate(0);
							}
						}
						i++;
						//temp.truncate();
					}
					if(block>0) {
						this.PartsInternal[block].data = e.slice(0, e.size-this.boundary.data.length-8).to_array();
					}
					foreach(var m in this.PartsInternal.entries) {
						this.Parts.add(m.value);
					}
					PartsInternal.clear();
				}
				catch(Error e) {
					stderr.printf(e.message+"\n");
				}
				//stdout.printf("\nDatos:\n%s\n", (string)e.to_array());
			}
		}
	}
	[Description(nick = "HTTP Response", blurb = "Response from server")]
	public class Response:GLib.Object {
		public  uint8[] Data = new uint8[0];
		public StatusCode Status = StatusCode.NOT_IMPLEMENTED;
		public HashMap<string, string> Header = new HashMap<string, string>();
		public Response() {
			Header["Server"] = VERSION;
			Header["Content-Type"] = "text/html";
		}
		public string ToString() {
			var Cadena = new StringBuilder();
			Cadena.append_printf("%s", HtmlStatusCode(this.Status));
			if(this.Header.has_key("Sec-WebSocket-Accept")) {
				Cadena.append("\r\n");
				//this is the end websocket
				this.Header["Sec-WebSocket-Accept"] = this.CalcHandshake();
			} else {
				Cadena.append("\n");
				//this is the end of the return headers
			}
			Cadena.append_printf("%s\r", KeyValueFile.HashMapToString(this.Header));
			return Cadena.str;
		}
		private string CalcHandshake() {
			string Retorno = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";
			if(this.Header.has_key("Sec-WebSocket-Key")) {
				Retorno = Base64.encode(Checksum.compute_for_string(ChecksumType.SHA1, Retorno+this.Header["Sec-WebSocket-Key"]).data);
			}
			return Retorno;
		}
		[Description(nick = "enum StatusCode to HTTP Status", blurb = "")]  
		private static string HtmlStatusCode(StatusCode sc) {
			string Retorno = "";
			switch(sc) {
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
		public static string HtmErrorPage(string title = "uHTTP WebServer", string error) {
			string Base = """<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>@Title</title>
</head>
<body  id="myapp">
 <div style="width: 100%;
			height: 100%;
			">
  <div style="border: 1px solid #423e3e;
			border-radius: 5px;
			-moz-border-radius: 5px;
			padding: 10px;
			-moz-box-shadow: 10px 10px 5px #000000;
			-webkit-box-shadow: 10px 10px 5px #000000;
			box-shadow: 10px 10px 5px #000000;
			clear: both;
			background-color: black;
			height: 150px;
			width: 550px;
			left: 50%;
			top: 50%;
			position: absolute;
			z-index: 900;
			margin-top: -150px;
			margin-left: -300px;
			">
  <img src="data:image/png;
			base64,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" style="margin: 5px;
			float: left;
			"></img>
    <div style="margin: 5px;
			font-family: Garamond, serif;
			line-height: 1em;
			color: #fa8c05;
			font-weight: bold;
			font-size: 40px;
			text-shadow: 0px 0px 0 rgb(226,116,-19),1px 1px 0 rgb(211,101,-34),2px 2px 0 rgb(197,87,-48),3px 3px 0 rgb(182,72,-63),4px 4px 0 rgb(168,58,-77),5px 5px 0 rgb(153,43,-92), 6px 6px 0 rgb(139,29,-106),7px 7px 6px rgba(0,0,0,0.6),7px 7px 1px rgba(0,0,0,0.5),0px 0px 6px rgba(0,0,0,.2);
			text-align: center;
			">
      @Error</div>
    <div style="color: white;
			position: relative;
			top: 80px;
			text-align: center;
			">
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
/*	
    public class TemporaryVariables:GLib.Object{

        private HashMap<string, string> Values = new HashMap<string, string>();

        public TemporaryVariables(){
        }

        public void set_value(string n, string v, int t = 10){
        Values[n] = v; 
        }

        public string get_value(string n){
        string r = "";
        if(Values.has_key(n)){
        r = Values[n];
        }
        return r;
        }
        
        public string set_value_random_name(string v, int t = 10){
        string n = "";
        Values[n] = v;
        return n; 
        }       

    }	
    */
    
    
    /**
    * Basic functions for reading and writing files.
    */    
    public class FileFunctions:GLib.Object{
        /**
        * file_name is the name of the file to be read or written. 
        * You may need to put the full path.
        */
        public string file_name = "file.uhttp";
        public string full_path{get; private set; default = "";}
           
            public FileFunctions(){
            }
            /**
            * Create the file if it does not exist with the data passed as a parameter.
            */
            public bool create_if_does_not_exist(uint8[] data = "".data){
                    var file = File.new_for_path (this.file_name);
                    this.full_path = file.get_path();

                    if (!file.query_exists ()) {
                        this.create_new_file(data);
                    }
                    return true;            
            }
            /**
            * Create a new file with the data passed as a parameter.
            */
            public long create_new_file(uint8[] data = "".data){
                return this.write_file(data);                
            }
            
            /**
            * Writes data to the file, replacing the previous.
            */
            public long write_file(uint8[] data = "".data){
                long written = 0;
                try {
                    // an output file in the current working directory
                    var file = File.new_for_path (this.file_name);
                	 this.full_path = file.get_path();
                   if (file.query_exists ()) {
                   file.delete ();
                    }

                    // creating a file and a DataOutputStream to the file
                    var dos = new DataOutputStream (file.create (FileCreateFlags.REPLACE_DESTINATION));
                    // For long string writes, a loop should be used, because sometimes not all data can be written in one run
                    // 'written' is used to check how much of the string has already been written
                    while (written < data.length) { 
                    // sum of the bytes of 'text' that already have been written to the stream
                    written += dos.write (data[written:data.length]);
                    }
                    
                } catch (Error e) {
                stderr.printf ("%s\n", e.message);
                }  
            return written;          
            }
            
            /**
            * Read binary data file.
            */
            public uint8[] read_file(){
                var file = File.new_for_path (this.file_name);
               // warning(file.get_path());
                uint8[] Retorno = {}; 
                if (file.query_exists ()) {
                        try {
                        
                         var file_info = file.query_info ("*", FileQueryInfoFlags.NONE);
                        //    stdout.printf ("File size: %lld bytes\n", file_info.get_size ());
                        Retorno = new uint8[file_info.get_size()];
                        // Open file for reading and wrap returned FileInputStream into a
                        // DataInputStream, so we can read line by line
                        var dis = new DataInputStream (file.read ());  
                        size_t bytes_read;
                       dis.read_all(Retorno, out bytes_read);
                       //message("File '%s' loading... %s = %s - %s\n", file.get_path (), (string)Retorno, bytes_read.to_string(), dis.has_pending ().to_string());
                    } catch (Error e) {
                        error ("%s", e.message);
                    } 
                }else{
                stderr.printf ("File '%s' doesn't exist.\n", file.get_path ());
                }  
                
                return Retorno;         
            }
            
            public BinaryData read_as_binarydata(){
            return new BinaryData(this.read_file());            
            }
            
            /**
            * Read data from the file and returns them as a string with only valid characters unichar.
            */
            public string load_only_valid_unichars(){
                var B = new BinaryData(this.read_file());
                return B.to_string_only_valid_unichars();                
            }
    

    
    } 
    
    public class KeyValueFile:FileFunctions{
    	public string Exp = """(?<key>[0-9\w]+):[\s]+(?<value>[0-9\w\s\W]+)""";
    	public string default_message = "";
    	public HashMap<string, string> KeyValue = new HashMap<string, string>();
    	public KeyValueFile(){
    		this.default_message = "# Configuration File";
    		//this.Exp = regex;
    		this.file_name = "kf.conf";
    	}
    
    		public static string HashMapToString(HashMap<string, string> hm) {
			var Retorno = new StringBuilder();
			foreach(var r in hm.entries) {
				Retorno.append_printf("%s: %s\n", r.key, r.value);
			}
			return Retorno.str;
		}

	public string to_string(string title = "KeyValueFile\n"){
		var Retorno = new StringBuilder(title);
		Retorno.append(HashMapToString(KeyValue));
		return Retorno.str;
	}
	    
    	public void load(){
                this.create_if_does_not_exist(this.default_message.data);
                var lines = this.load_only_valid_unichars().split("\n");
                try {
                	//warning(Exp);
                                	Regex RegExp = new Regex(Exp);       
					MatchInfo match;
					      
                    foreach(var l in lines){
                            if(!l.has_prefix("#") && l.length > 0){
                            
                               // warning(l);
					// Verify that the file passed as an argument matches any of the regular expression patterns.
						if(RegExp.match(l, RegexMatchFlags.ANCHORED, out match)) {
							//warning("Funca\n");	  
						  string? k = match.fetch_named("key");
						  string? v = match.fetch_named("value");
						  
						  if(k != null && k.length>0){
						  	if(v == null){
						  		v = "";
						  	}
						  	this.KeyValue[k] = v; 
						  }						  
						  
						}
				                                             
                            }

                        }
                        
                        }catch (RegexError err) {
							warning (err.message);
						}

                    
                   
            }
            
            public string get_as_string(string key){
            	if(KeyValue.has_key(key)){
            		return KeyValue[key];
            	}else{
            		return "";
            	}
            }
		public bool get_as_bool(string key){
            	if(KeyValue.has_key(key)){
            		return bool.parse(KeyValue[key]);
            	}else{
            		return false;
            	}
            }
            
		public uint16 get_as_uint16(string key){
            		return (uint16)this.get_as_int(key);
		}            
            
		public int get_as_int(string key){
            	if(KeyValue.has_key(key)){
            		return int.parse(KeyValue[key]);
            	}else{
            		return 0;
            	}
		}            
            
                
    
    }    
    
    
    /**
    * Loads the address list server files, regular expression format.
    * If the configuration file is changed the server must be restarted for the changes to take effect.
    */
    public class AddressListFiles:FileFunctions{
        public ArrayList<string> regular_expressions = new ArrayList<string>();    
        public string default_message = """#This file contains a list of the addresses of the files on the server and must be stored one per line and as regurar expression. 
#To disable log insert a # at the beginning of the line. 
#If you make any changes in this file will need to restart the server or wait about 5 minutes for the changes are automatically applied.""";
    
            /**
            * Constructor with the filename passed as a parameter to load
            */
            public AddressListFiles(){
            }   

            /**
            * Read the file data and loads the valid values ​​in the ArrayList regular_expressions
            */
            public void load(){
                this.create_if_does_not_exist(this.default_message.data);
                var lines = this.load_only_valid_unichars().split("\n");
                    foreach(var l in lines){
                            //stdout.printf ("-%s\n", l);
                            if(!l.has_prefix("#") && l.length > 0){
                                this.regular_expressions.add(l);                             
                            }

                        }            
                      
            }
    

    
    }     
    
    /**
    * This class represents binary data in uitn8[] with features that be converted to string
    */
    public class BinaryData:GLib.Object{
    
        private ArrayList<uint8> internal_data = new ArrayList<uint8>();
        
        public BinaryData(uint8[] binary = {}){
            this.data = binary;        
        }  
        
        public string md5(){
        return Checksum.compute_for_data (ChecksumType.MD5, this.data);
        }
        
        public int length{
        	get {
        		return internal_data.size;
        	}
        }
        
	public uint8[] data{
		owned get{
		
			return this.internal_data.to_array();
		}
		set{
			this.internal_data.clear();
			foreach(var d in value){
				this.internal_data.add(d);			
			}
		}
	}    
	
	  
            
        /**
        * Converts string data.
        */  
        public string to_string(){
            return (string)this.data;
        }
        
        public void add_uint8(uint8 byte){
          	this.internal_data.add(byte);   
        }
        /**
        * Convert data and returns them as a string with only valid characters unichar.
        */
        public string to_string_only_valid_unichars() {
			var R = new StringBuilder();
			string Cadena = this.to_string();
			int CLength = this.data.length;
			unichar caracter;
			if(CLength > 0) {
				for (int i = 0; Cadena.get_next_char(ref i, out caracter);) {
					if(i>CLength) {
						break;
					}
					if(caracter.validate()) {
						R.append_unichar(caracter);
					}
				}
			}
			return R.str;
		}
    
    }
    
    /**
    * Class that represents a list of cacheable addresses
    */
    public class CacheableAddress:AddressListFiles{
    
        /**
        * Array containing the cached files and your address.
        */
        public HashMap<string, BinaryData> cache = new HashMap<string, BinaryData>();
    
        public CacheableAddress(){
            this.file_name = "cache.uhttp";
            this.default_message = """#This file contains regular expressions that point to all the files that are saved in the cache server. 
#Place a regular expression for each line. 
#If you want to disable a line place the # sign at the beginning of the line. 
#Every change you make to this file will take effect once the server restarts.""";
            this.load();
        }
    
        /**
        * Verify that the file is cacheable.
        */
        public bool is_cacheable(string file_name){
            bool Retorno = false;
				foreach(string exp in this.regular_expressions) {
					try {
						Regex RegExp = new Regex(exp);
						MatchInfo match;
						// Verify that the file passed as an argument matches any of the regular expression patterns.
						if(RegExp.match(file_name, RegexMatchFlags.ANCHORED, out match)) {
						    this.add_cacheable_data(file_name);
						  //  warning("Coincide\n-%s\n-%s\n\n", file_name, exp);
							Retorno = true;
							break;
							}
						}
					catch (RegexError err) {
						warning (err.message);
						}
				}  
		    return Retorno;      
        }
        
        /**
        * Returns a BinaryData. 
        * If the file is cacheable returns from the cache, otherwise returns from the server.
        */
        public BinaryData return_file(string file_name){
            BinaryData R = new BinaryData();
            if(this.cache.has_key(file_name)){
                R = this.cache[file_name];
             //   message("Return from cache: %s\n", file_name);
            }else{
                FileFunctions F = new FileFunctions();
                F.file_name = file_name;
                R = F.read_as_binarydata();    
             //   message("Return from server: %s\n", file_name);         
            }
            return R;            
            }
        
        /**
        * Add a file to the cache.
        */
        private void add_cacheable_data(string file_name){
            if(!this.cache.has_key(file_name)){  
                FileFunctions F = new FileFunctions();
                F.file_name = file_name;
                this.cache[file_name] = F.read_as_binarydata(); 
                //message("Load %s on the cache\n", file_name);                     
            }       
        }
    
    }
    

	public class uHttpServerConfigFile:KeyValueFile{
	
		public uHttpServerConfigFile(){
			
			this.file_name = "uhttp.conf";
			this.load();
			this.to_environment_vars();
		}
		
		public void to_environment_vars(){
			Environment.set_variable("uhttp_upload_temp_dir", this.get_as_string("UploadTempDir"), true);
			Environment.set_variable("uhttp_upload_max_filesize", this.get_as_string("UploadMaxFilesize"), true);
			Environment.set_variable("uhttp_document_root", this.get_as_string("DocumentRoot"), true);
			
			//warning(this.full_path);
			
					
		}
	
	}    
	
	[Description(nick = "HTTP Server", blurb = "Micro embebed HTTP Web Server")]
	public class uHttpServer:GLib.Object {
		[Description(nick = "Signal Request URL No Found", blurb = "Señal se dispara cuando una página no es encontrada en el servidor")]
		public signal void NoFoundURL(Request request);
        public CacheableAddress Cache = new CacheableAddress();
        
		public signal void heartbeat(int seconds);
		public int heartbeatseconds = 30;
		private ThreadedSocketService tss;
		[Description(nick = "Config uHTTP", blurb = " Data Config uHTTP")]
		public uHttpServerConfigFile Config = new uHttpServerConfigFile();
//		public TemporaryVariables TempGlobalVars  = new TemporaryVariables();
		[Description(nick = "Constructor uHttpServer", blurb = "")]  
		  public uHttpServer(int max_threads = 100) {
		  	//Config.to_environment_vars();
		  	
		  	
			//make the threaded socket service with hella possible threads
			tss = new ThreadedSocketService(max_threads);
			/* connect the 'run' signal that is emitted when 
     * there is a connection to our connection handler
     */
			this.thread_heartbeat();
			tss.run.connect( connection_handler );
		}
		private void thread_heartbeat() {
			if (!Thread.supported()) {
				stderr.printf("Cannot run without threads.\n");
			} else {
				try {
					Thread.create<void>(this.trigger_heartbeat, false);
				}
				catch(ThreadError e) {
					print(e.message);
				}
			}
		}
		private void trigger_heartbeat() {
			while(true) {
				if(this.heartbeatseconds < 1) {
					this.heartbeatseconds = 1;
				}
				this.heartbeat(this.heartbeatseconds);
				Thread.usleep(1000000*this.heartbeatseconds);
			}
		}
		
		
		public static string EnumToXml(Type typeenum, bool fieldtextasbase64 = true) {
			var Retorno = new StringBuilder("<enum>");
			var TempNick = new StringBuilder();
			EnumClass enum_class = (EnumClass) typeenum.class_ref ();
			foreach(var item in enum_class.values) {
				TempNick.truncate();
				if(item.value_nick.length>0) {
					TempNick.append(item.value_nick);
				} else {
					TempNick.append(item.value_name);
				}
				if(fieldtextasbase64) {
					Retorno.append_printf("<item><name>%s</name><value>%s</value></item>", Base64.encode(TempNick.str.data), item.value.to_string());
				} else {
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
			InetSocketAddress isa = new InetSocketAddress(ia, Config.get_as_uint16("Port"));
			//try to add the address to the ThreadedSocketService
			try {
				tss.add_address(isa, SocketType.STREAM, SocketProtocol.TCP, null, null);
			}
			catch(Error e) {
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
			//print("Contact: software@edwinspire.com\n");
			//print("Contact: http://www.edwinspire.com\n\n");
			stdout.printf("%s\n", Config.to_string("Configuration Server:\n"));
			/*
			stdout.printf("Port: %s\n", Config.get_as_string("Port"));
			stdout.printf("Root: %s\n", Config.get_as_string("DocumentRoot"));
			stdout.printf("Index: %s\n", Config.get_as_string("Index"));*/
			ml.run();
		}
		public void run_without_mainloop() {
			//create an IPV4 InetAddress bound to no specific IP address
			InetAddress ia = new InetAddress.any(SocketFamily.IPV4);
			//create a socket address based on the netadress and set the port
			InetSocketAddress isa = new InetSocketAddress(ia, Config.get_as_uint16("Port"));
			//try to add the address to the ThreadedSocketService
			try {
				tss.add_address(isa, SocketType.STREAM, SocketProtocol.TCP, null, null);
			}
			catch(Error e) {
				stderr.printf(e.message+"\n");
				return;
			}
			//we need a gobject main loop
			//    MainLoop ml = new MainLoop();
			//start listening 
			tss.start();
			stdout.printf("Serving on port %s\n", Config.get_as_string("Port"));
			//tss.
			//run the main loop
			//  ml.run();
		}
		public bool upload_file_on_documentroot(string subpath_file, uint8[] data, bool replace = false) {
			return upload_file(Environment.get_variable("uhttp_document_root"), subpath_file, data, replace);
		}
		
		public bool upload_file(string path, string file, uint8[] data, bool replace = false) {
			return save_file(Path.build_path (Path.DIR_SEPARATOR_S, path, file), data, replace);
		}
		
		public bool save_file_into_temp_dir(string file, uint8[] data, bool replace = false) {
			return save_file(full_path_temp_file(file), data, replace);
		}
		
		public static string full_path_temp_file(string filename){
			return Path.build_path (Path.DIR_SEPARATOR_S, Environment.get_variable("uhttp_upload_temp_dir"), filename);		
		}

		
		public static bool save_file(string path, uint8[] data, bool replace = false) {
			bool R = false;
			try {
				// stderr.printf ("PATH\n%s\n", path);
				// Reference a local file name
				var file = File.new_for_path (path);
				var exist = file.query_exists ();
				if(exist && replace) {
					file.delete ();
				}
				// Test for the existence of file
				if (!exist) {
					var dos = new DataOutputStream (file.create (FileCreateFlags.REPLACE_DESTINATION));
					// For long string writes, a loop should be used, because sometimes not all data can be written in one run
					// 'written' is used to check how much of the string has already been written
					long written = 0;
					while (written < data.length) {
						// sum of the bytes of 'text' that already have been written to the stream
						written += dos.write (data[written:data.length]);
					}
					if(data.length == written) {
						R = true;
					}
				} else {
					R = true;
				}
			}
			catch(GLib.Error e) {
				stdout.printf ("Error: %s\n", e.message);
			}
			return R;
		}
		public static string get_data_as_string_valid_unichars(uint8[] d) {
			var R = new StringBuilder();
			string Cadena = (string)d;
			int CLength = d.length;
			unichar caracter;
			if(CLength > 0) {
				for (int i = 0; Cadena.get_next_char(ref i, out caracter);) {
					if(i>CLength) {
						break;
					}
					if(caracter.validate()) {
						R.append_unichar(caracter);
					}
				}
			}
			return R.str;
		}
		[Description(nick = "GenUrl", blurb = "Crea una Url unica automaticamente")]  
		public static string GenUrl(string root = "/", string value = "Sf54+-dsfk%6md&bfpJ") {
			TimeVal tv = TimeVal();
			tv.get_current_time();
			return root+Checksum.compute_for_string(ChecksumType.MD5, value+"-"+tv.to_iso8601 ())+Checksum.compute_for_string(ChecksumType.MD5, root);
		}
		public virtual bool connection_handler_virtual(Request request, DataOutputStream dos) {
			uHttp.Response response = new uHttp.Response();
			response.Status = StatusCode.NOT_FOUND;
			response.Data = Response.HtmErrorPage("uHTTP WebServer", "404 - Página no encontrada").data;
			response.Header["Content-Type"] = "text/html";
			this.serve_response( response, dos );
			return false;
		}
		
		public void upload_file_signal(BinaryData binary, string filename){
		
			if(binary.length <= int.parse(Environment.get_variable("uhttp_upload_max_filesize"))*1000000){
				this.save_file_into_temp_dir(binary.md5()+".tmp", binary.data, false);
			}else{
				warning("El archivo "+filename+" excede el limite maximo permitido para subida\n");		
			}
		
			
		}
		
		//**************************************************************
		//when a request is made, handle the socket connection
		private bool connection_handler(SocketConnection connection) {
			size_t size = 0;
			Request request = new Request();
			request.Form.post_request.file_uploaded.connect(upload_file_signal);

			//get data input and output streams for the connection
			DataInputStream dis = new DataInputStream(connection.input_stream);
			DataOutputStream dos = new DataOutputStream(connection.output_stream);
			//	stdout.printf(connection.has_pending().to_string());
			try {
				string firstblock ="";
				var PrimerBloque = new StringBuilder();
				int maxline = 500;
				while(maxline>0) {
					firstblock = dis.read_line( out size );
					if(firstblock != null) {
						PrimerBloque.append(firstblock);
					}
					if(firstblock=="\r" || firstblock == null) {
						break;
					}
					maxline--;
				}
				request.from_lines(PrimerBloque.str);
				PrimerBloque.truncate();
				if(request.ContentLength>0) {
					size_t sz;
					uint8[] datos = new uint8[request.ContentLength];
					dis.read_all (datos, out sz);
					request.Data = datos;
				}else{
					request.Data = {};
				}

				if(Config.get_as_bool("RequestPrintOnConsole")) {
					request.print();
				}
			}
			catch (Error e) {
				warning(e.message+"\n");
			}
			Response response = new Response();
			string FullPath = this.PathLocalFile(request.Path);
			if(Cache.is_cacheable(FullPath)){
				// Devuelve el archivo directo de la cache 
				response.Status = StatusCode.OK;
				response.Data = Cache.return_file(FullPath).data;
				response.Header["Content-Type"] = GetMimeTypeToFile(FullPath);
				serve_response( response, dos );						
			}else if(request.Path == "/") {
				// Carga la pagina inicial del servidor
				response.Status = StatusCode.OK;
				response.Data = LoadServerFile(Config.get_as_string("Index"));
				response.Header["Content-Type"] = "text/html";
				serve_response( response, dos );
			} else if(request.Path  == "/config.uhttp") {
				// Devuelva una lista en xml de la configuración del sistema
				response.Status = StatusCode.OK;
				// TODO No implementado
				//response.Data = LoadFile(Config.ToXml());
				response.Header["Content-Type"] = "text/xml";
				serve_response( response, dos );
			} /*else if(request.Path  == "/joinjsfiles.uhttp") {
				//TODO:
				// Esta seccion es una utilidad del servidor que permite unir varios archivos javascript en uno solo y enviarlo a cliente, esto elimina la cantidad de peticiones hechas al servidor y carga mas rapido la pagina. 
				// Los scripts separados por comas, sin el .js y el path relativo o absoluto
				// Recordar que es una peticion GET por lo que el limite del string 
				// el formato de envio es /joinjsfiles.uhttp?files=/script1,/script2,/script3
				var textjoin = new StringBuilder();
				var pathjs = new StringBuilder();
				response.Status = StatusCode.OK;
				response.Header["Content-Type"] = "application/javascript";
				if(request.Query.has_key("files")) {
					foreach(var p in request.Query["files"].split(",")) {
						pathjs.truncate();
						pathjs.append_printf("%s.js", PathLocalFile(p));
						if(FileUtils.test(pathjs.str, GLib.FileTest.IS_REGULAR)) {
							textjoin.append_printf("%s ", ReadJavaScriptFile(pathjs.str));
						}
					}
				}
				response.Data = textjoin.str.data;
				serve_response( response, dos );
			} */else if(FileUtils.test(FullPath, GLib.FileTest.IS_REGULAR)) {
				// Es un archivo local. Lo carga y lo envia al cliente
				response.Status = StatusCode.OK;
				string new_name = "";
					if(PHP_Support.is_script(request.Path, ref new_name)){
						PHP_Support PHP = new PHP_Support();
						//PHP.Path_Uploads = Config.get_as_string("Uploads");
						//PHP.DocumentRoot = Config.get_as_string("DocumentRoot");
						response.Header["Content-Type"] = GetMimeTypeToFile(new_name);
						response.Data = PHP.run_script(FullPath, ref request).data;
						//print("PHP devuelve %s\n", (string)response.Data);
					}else{
						response.Header["Content-Type"] = GetMimeTypeToFile(request.Path);
						response.Data = LoadServerFile(request.Path);				
					}
				serve_response( response, dos );
				
			} else if(request.Path == "/uhttp-websocket-echo.uhttp") {
				if(request.isWebSocketHandshake) {
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
			} else {
				NoFoundURL(request);
				print("No found %s\n", request.Path);
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
		//********************************************************************
		[Description(nick = "Server Response", blurb = "")]  
		  public void serve_response(Response response, DataOutputStream dos) {
			var Temporizador = new Timer();
			Temporizador.start();
			var Encabezado = new StringBuilder();
			Encabezado.append_printf("%s", response.ToString());
			Encabezado.append("\n");
			//this is the end of the return headers
			writeData(Encabezado.str.data, dos);
			writeData(response.Data, dos);
			if((Temporizador.elapsed()*1000)>2000) {
				stderr.printf("uHttpServer slow response\n");
			}
			Temporizador.stop();
		}
		public long writeData(uint8[] data_, DataOutputStream dos) {
			long written = 0;
			try {
				if(data_.length>0) {
					while (written < data_.length) {
						// sum of the bytes of 'text' that already have been written to the stream
						written += dos.write (data_[written:data_.length]);
					}
				}
			}
			catch( Error e ) {
				//      stderr.printf(e.message+"\n");
				warning(e.message+"\n");
			}
			return written;
		}
		public void sendEventHeader(DataOutputStream dos) {
			uHttp.Response Retorno = new uHttp.Response();
			Retorno.Header["Content-Type"] = "text/event-stream";
			Retorno.Header["Cache-Control"] = "no-cache";
			Retorno.Status = StatusCode.OK;
			this.serve_response( Retorno, dos );
		}
		public long sendEvent(string data, DataOutputStream dos) {
			return this.writeData(("data: "+data+"\n\n").data, dos);
		}
		// Obtiene el path local del archivo solicitado
		public string PathLocalFile(string Filex) {
			return Path.build_path (Path.DIR_SEPARATOR_S, Environment.get_variable("uhttp_document_root"), Filex);
		}
		public static string ReadFile(string path) {
			return (string)LoadFile(path);
		}/*
		private static string ReadJavaScriptFile(string path) {
			return ReadFile(path);
		}*/
		public uint8[] LoadServerFile(string path) {
			return LoadFile(PathLocalFile(path));
		}
		public string ReadServerFile(string path) {
			return (string)LoadServerFile(path);
		}
		// Carga los datos de un archivo local
		public static uint8[] LoadFile(string Path) {
			uint8[] buffer = new uint8[0];
			if(Path.length>3) {
				try {
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
				catch(Error e) {
					GLib.warning ("[%s]\n%s\n", e.message, Path);
				}
			}
			return buffer;
		}
		public static string get_extension_file(string file_name) {
			string basen = Path.get_basename(file_name).reverse();
			var exten = basen.split(".");
			if(exten.length>0) {
				basen = exten[0].reverse();
			} else {
				basen = "";
			}
			return basen;
		}
		// Define el MIME tpe segun la extension del archivo
		private static string GetMimeTypeToFile(string path) {
			string Retorno = "text/plain";
			string basen = get_extension_file(path);
			//print("%s\n", basen);
			switch(basen) {
				case "html":
				Retorno = "text/html";
				break;
				case "wav":
				Retorno = "audio/wav";
				break;
				case "xml":
				Retorno = "text/xml";
				break;
				case "txt":
				Retorno = "text/plain";
				break;
				// Formato whtml de edwinspire para crear paginas html con widgtes
				case "whtml":
				Retorno = "text/html";
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
				case "php":
				Retorno = "text/x-php";
				break;
				case "ogg":
				Retorno = "application/ogg";
				break;
				case "mp3":
				Retorno = "audio/mpeg3";
				break;
				case "ttf":
				Retorno = "font/opentype";
				break;
				default:
				Retorno = "text/plain";
				print(@"Mimetype Desconocido para [$basen] devuelve $Retorno [$path]\n");
				break;
			}
			return Retorno;
		}
	}
}
