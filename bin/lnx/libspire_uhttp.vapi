/* libspire_uhttp.vapi generated by valac 0.16.1, do not modify. */

namespace edwinspire {
	namespace uHttp {
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "", nick = "HTTP Form")]
		public class Form : GLib.Object {
			public Form ();
			[Description (blurb = "Get data From Form", nick = "Form Data Decode")]
			public static Gee.HashMap<string,string> DataDecode (string? data);
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "HTTP Base Header", nick = "HTTP Header")]
		public class Header : GLib.Object {
			public string CacheControl;
			public string Connection;
			public string ContentEncoding;
			public int ContentLength;
			public string ContentLenguaje;
			public string ContentLocation;
			public string ContentMD5;
			public string ContentRange;
			public string ContentType;
			public string Date;
			public string Expires;
			public string HttpVersion;
			public string LastModified;
			public string Pragma;
			public string Range;
			public string Trailer;
			public string TransferEncoding;
			public string Upgrade;
			public string Via;
			public string Warning;
			public Header ();
			public virtual string ToString ();
			public virtual void print ();
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "", nick = "HTTP Request")]
		public class Request : GLib.Object {
			public Gee.HashMap<string,string> Header;
			public edwinspire.uHttp.RequestMethod Method;
			public string Path;
			[Description (blurb = "Query pased by url, Method GET", nick = "Query")]
			public Gee.HashMap<string,string> Query;
			public Request ();
			public void print ();
			public int ContentLength { get; }
			public uint8[] Data { get; set; }
			[Description (blurb = "Content sent by User Agent from POST", nick = "Content Form")]
			public Gee.HashMap<string,string> Form { get; private set; }
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "Response from server", nick = "HTTP Response")]
		public class Response : GLib.Object {
			public uint8[] Data;
			public edwinspire.uHttp.ResponseHeader Header;
			public Response ();
			public static string HtmErrorPage (string title = "uHTTP WebServer", string error);
			public string ToString ();
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "", nick = "HTTP Response Header")]
		public class ResponseHeader : edwinspire.uHttp.Header {
			public string AcceptRanges;
			public string Age;
			public string ETag;
			public string Location;
			public string ProxyAuthenticate;
			public string RetryAfter;
			public string Server;
			public edwinspire.uHttp.StatusCode Status;
			public string WWWAuthenticate;
			public ResponseHeader ();
			[Description (blurb = "", nick = "enum StatusCode to HTTP Status")]
			public static string HtmlStatusCode (edwinspire.uHttp.StatusCode sc);
			public string StatusString ();
			public override string ToString ();
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "Micro embebed HTTP Web Server", nick = "HTTP Server")]
		public class uHttpServer : GLib.Object {
			[Description (blurb = " Data Config uHTTP", nick = "Config uHTTP")]
			public edwinspire.uHttp.uHttpServerCongif Config;
			[Description (blurb = "", nick = "Constructor uHttpServer")]
			public uHttpServer (int max_threads = 100);
			public static string EnumToXml (GLib.Type typeenum, bool fieldtextasbase64 = true);
			[Description (blurb = "Crea una Url unica automaticamente", nick = "GenUrl")]
			public static string GenUrl (string root = "/", string value = "Sf54+-dsfk%6md&bfpJ");
			public static uint8[] LoadFile (string Path);
			public string PathLocalFile (string Filex);
			public static string ReadFile (string path);
			public virtual bool connection_handler_virtual (edwinspire.uHttp.Request request, GLib.DataOutputStream dos);
			[Description (blurb = "Run on MainLoop", nick = "Run Server")]
			public virtual void run ();
			public void run_without_mainloop ();
			[Description (blurb = "", nick = "Server Response")]
			public void serve_response (edwinspire.uHttp.Response response, GLib.DataOutputStream dos);
			[Description (blurb = "Señal se dispara cuando una página no es encontrada en el servidor", nick = "Signal Request URL No Found")]
			public signal void NoFoundURL (edwinspire.uHttp.Request request);
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "Micro embebed HTTP Web Server config file", nick = "HTTP Server Config")]
		public class uHttpServerCongif : GLib.Object {
			[Description (blurb = "Index page, default: index.html", nick = "Index")]
			public string Index;
			[Description (blurb = "Default: 8080", nick = "Port")]
			public uint16 Port;
			public bool RequestPrintOnConsole;
			[Description (blurb = "Default: rootweb on current directory.", nick = "Path Root")]
			public string Root;
			public uHttpServerCongif ();
			public static string HashMapToString (Gee.HashMap<string,string> hm);
			public string ToXml (bool fieldtextasbase64 = true);
			public void read ();
			public bool write ();
			[Description (blurb = "", nick = "Signal on write file")]
			public signal void FileWrited ();
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "", nick = "HTTP Version")]
		public enum HTTPVersion {
			@1_0,
			@1_1
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "", nick = "HTTP Request Method")]
		public enum RequestMethod {
			UNKNOW,
			GET,
			POST,
			HEAD
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "", nick = "HTTP Status Code")]
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
	}
}
