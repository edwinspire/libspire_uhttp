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
using edwinspire.utils;

namespace edwinspire.uHttp {
	const string VERSION = "uHttp Server Version 0.3.1 Alpha";
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

	/**
	* HTTP version numbers
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
		/**
		* Requests data from a specified resource
		*/
		GET,
		/**
		* Submits data to be processed to a specified resource
		*/
		POST,
		/**
		* Same as GET but returns only HTTP headers and no document body
		*/
		HEAD,
		/**
		* Uploads a representation of the specified URI
		*/
		PUT,
		/**
		* Deletes the specified resource
		*/
		DELETE,
		/**
		* Returns the HTTP methods that the server supports
		*/
		OPTIONS,
		/**
		* Converts the request connection to a transparent TCP/IP tunnel
		*/
		CONNECT
	}
	
	/**
	* Request
	* Class representing a request
	*/
	[Description(nick = "HTTP Request", blurb = "")]
	public class Request:GLib.Object {
		public RequestMethod Method {
			get;
			private set;
			default = RequestMethod.UNKNOW;
		}
		
		/**
		* Path
		* Path file of the request
		*/
		public  string Path {
			get;
			private set;
			default = "";
		}
		
		/**
		* Url Query
		* Query sent in the URL
		*/
		public  string url_query {
			get;
			private set;
			default = "";
		}
		
		/**
		* Form
		* Form data sent in the request on GET or POST method
		*/		
		public FormRequest Form = new FormRequest();
		
		/**
		* Header
		* Request Headers
		*/
		public HashMap<string, string> Header {
			get;
			private set;
			default = new HashMap<string, string>();
		}
		//public RequestHeader Header = new RequestHeader();
		[Description(nick = "Content data", blurb = "Content sent by User Agent")]
		private uint8[] DatasInternal =  new uint8[0];
		
		public bool isWebSocketHandshake {
			get;
			private set;
			default = false;
		}
		public Request() {
		}
		/**
		* from_lines
		* Decodes the data from request
		*/
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
						} else if(line.has_prefix("DELETE")) {
							this.Method   = RequestMethod.DELETE;
						} else if(line.has_prefix("OPTIONS")) {
							this.Method   = RequestMethod.OPTIONS;
						} else if(line.has_prefix("CONNECT")) {
							this.Method   = RequestMethod.CONNECT;
						}
						
						//get the parts from the line
						string[] partsline = line.split(" ");
						if(partsline.length==3) {
							var partsquery = partsline[1].split("?");
							if(partsquery.length>0) {
								this.Path = FileFunctions.text_strip(partsquery[0]);
								if(partsquery.length>1) {
	
								this.url_query = partsquery[1];

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
		/**
		* Content Length
		* Content length sent in the header.
		*/
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
			stdout.printf("*****************\n");
			stdout.printf("[*** REQUEST ***]\n");
			//stdout.printf("isWebSocketHandshake => %s\n", this.isWebSocketHandshake.to_string());
			stdout.printf("Method => %s\n", this.Method.to_string());
			stdout.printf("Path => %s\n", Path);
			stdout.printf("[Header]\n%s\n", KeyValueFile.HashMapToString(this.Header));			
			stdout.printf("[DATAS]\n%s\n", Form.to_string());
			
			
		}
		
		/**
		* Data
		* 
		*/
		public uint8[] Data {
			get {
				return DatasInternal;
			}
			set {
				DatasInternal = value;				
			this.Form.decode(this.Method, this.Header, this.url_query, this.DatasInternal);					
			}
		}
	}
	
	
	/**
	* Class representing a response from the server.
	*/
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
		
		/**
		* Returns a string of HTML code with error message will be displayed in the browser.
		*/
		public static string HttpError(string error, string description = "", string title = "uHTTP Micro Web Server") {
			string Base  = """
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>@Title</title>
</head>
<body data-maq-ws="collapse" data-maq-comptype="desktop" data-maq-flow-layout="true" data-maq-appstates="{}" id="myapp">
 <div style="width: 100%; height: 100%;">
  <div style="border-radius: 6px; -moz-border-radius: 6px; margin: auto; padding: 1em; text-shadow: 3px 3px 2px rgba(150, 150, 150, 1); -moz-box-shadow: 7px 7px 5px 0px rgba(50, 50, 50, 0.75); width: 50%; top: 25%; box-shadow: 3px 3px 13px 0px rgba(50, 50, 50, 0.75); position: absolute; z-index: 900; right: 25%; height: auto;">
   <div style="clear: both; text-align: center; font-weight: bold; font-size: 2em;">
     
   uHTTP - Micro Web Server</div>
   <div style="padding: 0.5em; text-align: center; font-size: 1.5em; color: #6e0000; font-weight: bold;">
     @Error</div>
   <div style="text-align: center;">
   @ErrorDescription</div>
   <p style="height: 10px;"></p>
   <div>
     uHTTP is open source and available on GitHub</div></br>
 
   <div>
     Micro Web Server:</div>
   <div>
     https://github.com/edwinspire/uhttp</div></br>
 
   
   <div>
     Library for an embedded server:</div>
   <div>
     https://github.com/edwinspire/libspire_uhttp</div>
 
 
 </div>
</div>
  </body>
    <div style="margin: 5px"></div>

</html>
""";

			string Retorno = Base.replace("@Title", title);
			Retorno = Retorno.replace("@ErrorDescription", description);
			Retorno = Retorno.replace("@Error", error);
			return Retorno;
		}
	}
    
    
    
  
    
    


    
    /**
    * Class that represents a list of cacheable addresses
    */
    public class CacheableAddress:FilesLinesArray{
    
        /**
        * Array containing the cached files and your address.
        */
        public HashMap<string, BinaryData> cache = new HashMap<string, BinaryData>();
    
    	/**
    	* Constructor
    	*/
    	public CacheableAddress(){
    		this.file_name = "cache.uhttp";
    	}
    
        public void load_config(){
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
				foreach(string exp in this.Lines) {
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
    
        /**
        * Class that represents the server configuration file.
        */
	public class uHttpServerConfigFile:KeyValueFile{
	
		 public CacheableAddress Cache = new CacheableAddress();
	
		public uHttpServerConfigFile(){
			this.default_message = """#Puerto / Socket, default = 8081
Port: 8081
#Página de inicio, default = index.html
Index: index.html
#Carpeta raíz de los documentos del servidor web. La ruta puede ser absoluta, o si la ruta inicia con * se tomará como relativa a la ubicación donde está corriendo el servidor. Si se deja vacio se tomará como raiz una carpeta llamada uhttproot dentro de la ubicación actual del servidor.
#DocumentRoot: 
#Imprime en consola las peticiones realizadas al servidor
RequestPrintOnConsole: true
#==============================
#UploadTempDir: 
UploadMaxFilesize: 10
#CacheConfigFile Full Path of configuration file cache.
#CacheConfigFile: """;

			
			this.file_name = "uhttp.conf";
		}
		
		/**
		* Load configuration from the file.
		*/
		public void load_config(){
		
			//this.file_name = full_path_file;
			this.load();
			
			if(!this.KeyValue.has_key("DocumentRoot") || this.get_as_string("DocumentRoot").length <= 1 || this.get_as_string("DocumentRoot").contains("*")){
				this.KeyValue["DocumentRoot"] = Path.build_path (Path.DIR_SEPARATOR_S, Environment.get_current_dir(), "uhttproot");
			}
			
			if(!this.KeyValue.has_key("UploadTempDir") || this.get_as_string("UploadTempDir").length < 1){
				this.KeyValue["UploadTempDir"] = Path.build_path (Path.DIR_SEPARATOR_S, Environment.get_tmp_dir());
			}
			
			if(!this.KeyValue.has_key("CacheConfigFile") || this.get_as_string("CacheConfigFile").length < 1){
				this.KeyValue["CacheConfigFile"] = Path.build_path (Path.DIR_SEPARATOR_S, Environment.get_current_dir(), "cache.uhttp");
			}			
			
			if(!this.KeyValue.has_key("UploadMaxFilesize") || this.get_as_int("UploadMaxFilesize") < 0){
				this.KeyValue["UploadMaxFilesize"] = "1";
			}
			
			Cache.file_name = this.KeyValue["CacheConfigFile"];
			Cache.load_config();
		}
		
	
	}    
	
	
        /**
        * Class that represents the server uHTTP.
        */	
	[Description(nick = "HTTP Server", blurb = "Micro embebed HTTP Web Server")]
	public class uHttpServer:GLib.Object {
		[Description(nick = "Signal Request URL No Found", blurb = "Señal se dispara cuando una página no es encontrada en el servidor")]
		public signal void NoFoundURL(Request request);
       
        
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
		  	Config.load_config();
		  	start_server_message_on_console();
		  	var p = Config.get_as_uint16("Port");
		  	if(p>0){
			//create an IPV4 InetAddress bound to no specific IP address
			InetAddress ia = new InetAddress.any(SocketFamily.IPV4);
			//create a socket address based on the netadress and set the port
			InetSocketAddress isa = new InetSocketAddress(ia, p);
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
			ml.run();
			}else{
				stderr.printf("Invalid Port = %s\n", p.to_string());
				return;
			}
		}
		
		private void start_server_message_on_console(){
			var Text = new StringBuilder();
			Text.append("\n*******************************\n");
			Text.append("* Start uHTTP Micro WebServer *\n");
			Text.append_printf("Version: %s\n", VERSION);
			Text.append_printf("Licence: LGPL\n");
			Text.append_printf("Contact: edwinspire@gmail.com\n");
			Text.append_printf("         https://github.com/edwinspire?tab=repositories\n");
			//print("Contact: software@edwinspire.com\n");
			//print("Contact: http://www.edwinspire.com\n\n");
			Text.append_printf("%s\n", Config.to_string("[Configuration]\n"));
			print(Text.str);
		}
		
		[Description(nick = "Run Server", blurb = "Run without MainLoop")]
		public void run_without_mainloop() {
			Config.load_config();
			start_server_message_on_console();
			var p = Config.get_as_uint16("Port");
			//create an IPV4 InetAddress bound to no specific IP address
			if(p>0){
				InetAddress ia = new InetAddress.any(SocketFamily.IPV4);
			//create a socket address based on the netadress and set the port
			InetSocketAddress isa = new InetSocketAddress(ia, p);
			//try to add the address to the ThreadedSocketService
			try {
				tss.add_address(isa, SocketType.STREAM, SocketProtocol.TCP, null, null);
			}
			catch(Error e) {
				stderr.printf(e.message+"\n");
				return;
			}

			//start listening 
			tss.start();
		
			}else{
				stderr.printf("Invalid Port = %s\n", p.to_string());
				return;
			}	//tss.
		
		}
		
        /**
        * Upload a file to the folder passed as a parameter that is within the document root.
        */		
		public long upload_file_on_documentroot(string subpath_file, uint8[] data, bool replace = false) {
			return upload_file(Config.get_as_string("DocumentRoot"), FileFunctions.text_strip(subpath_file), data, replace);
		}

        /**
        * Upload a file to the folder passed as a parameter.
        */		
		public long upload_file(string path, string file, uint8[] data, bool replace = false) {
			return FileFunctions.save_file(Path.build_path (Path.DIR_SEPARATOR_S, FileFunctions.text_strip(path), FileFunctions.text_strip(file)), data, replace);
		}
        /**
        * Upload a file to the temp folder defined in the server configuration file.
        */		
		public long save_file_into_temp_dir(string file, uint8[] data, bool replace = false) {
			return FileFunctions.save_file(full_path_temp_file(FileFunctions.text_strip(file)), data, replace);
		}
		
		private string full_path_temp_file(string filename){
			return Path.build_path (Path.DIR_SEPARATOR_S, Config.get_as_string("DocumentRoot"), filename);		
		}

  /*
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
		}*/
		[Description(nick = "GenUrl", blurb = "Crea una Url unica automaticamente")]  
		public static string GenUrl(string root = "/", string value = "Sf54+-dsfk%6md&bfpJ") {
			TimeVal tv = TimeVal();
			tv.get_current_time();
			return root+Checksum.compute_for_string(ChecksumType.MD5, value+"-"+tv.to_iso8601 ())+Checksum.compute_for_string(ChecksumType.MD5, root);
		}
		public virtual bool connection_handler_virtual(Request request, DataOutputStream dos) {
			uHttp.Response response = new uHttp.Response();
			response.Status = StatusCode.NOT_FOUND;
			response.Data = Response.HttpError("404 - PAGE NOT FOUND", "The page you requested could not be found . You may have mistyped the address or the page has been removed.").data;
			response.Header["Content-Type"] = "text/html";
			this.serve_response( response, dos );
			return false;
		}
		
		public void upload_file_signal(BinaryData binary, string filename){
		
			if(binary.length <= (Config.get_as_int("UploadMaxFilesize"))*1000000){
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
			request.Form.path_file_tmp = Config.get_as_string("UploadTempDir");
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
			
			if(request.Method != RequestMethod.UNKNOW){
			
			Response response = new Response();
			
			string FullPath = this.PathLocalFile(request.Path);
			
			
			if(request.Path == "/"){
				FullPath = this.PathLocalFile(Config.get_as_string("Index"));
				//warning(FullPath);
			}
			
			if(Config.Cache.is_cacheable(FullPath)){
				// Devuelve el archivo directo de la cache 
				response.Status = StatusCode.OK;
				response.Data = Config.Cache.return_file(FullPath).data;
				response.Header["Content-Type"] = GetMimeTypeToFile(FullPath);
				serve_response( response, dos );						
			/*}else if(request.Path == "/") {
				// Carga la pagina inicial del servidor
				response.Status = StatusCode.OK;
				response.Data = LoadServerFile(Config.get_as_string("Index"));
				response.Header["Content-Type"] = "text/html";
				serve_response( response, dos );*/
			}else if(request.Path  == "/config.uhttp") {
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
						response.Data = PHP.run_script(FullPath, Config.get_as_string("DocumentRoot"), Config.get_as_string("UploadTempDir"), ref request).data;
						//print("PHP devuelve %s\n", (string)response.Data);
					}else{
						response.Header["Content-Type"] = GetMimeTypeToFile(FullPath);
						response.Data = LoadFile(FullPath);				
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
				print("No found %s\n", FullPath);
				//     response.Header.Status = StatusCode.NOT_FOUND;
				//  response.Data = Response.HttpError("uHTTP WebServer", "404 - Página no encontrada").data;
				//  response.Header.ContentType = "text/html";
				//    serve_response( response, dos );
				// stderr.printf("Path no found: %s\n", request.Path);
				// Si no se han encontrado el archivo dentro del servidor se buscará en las paginas virtuales. 
				this.connection_handler_virtual(request, dos);
			}
			
			}else{
			
			
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
			return Path.build_path (Path.DIR_SEPARATOR_S, Config.get_as_string("DocumentRoot"), Filex);
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
