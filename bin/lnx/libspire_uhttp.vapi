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
		public class MultiPartFormData : GLib.Object {
			public MultiPartFormData ();
			public void decode (string ContentTypeHeader, uint8[] d);
			public Gee.ArrayList<edwinspire.uHttp.MultiPartFormDataPart> Parts { get; private set; }
			[Description (blurb = "Boundary", nick = "Multi Part Form Boundary")]
			public string boundary { get; private set; }
			public bool is_multipart_form_data { get; private set; }
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		public class MultiPartFormDataHeader : GLib.Object {
			public MultiPartFormDataHeader ();
			public string get_param_for_name (string name);
			public string name { get; set; }
			public Gee.HashMap<string,string> param { get; set; }
			public string value { get; set; }
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		public class MultiPartFormDataPart : GLib.Object {
			public MultiPartFormDataPart ();
			public string compute_md5_for_data ();
			public string get_content_disposition_param (string name);
			public string get_data_as_string_valid_unichars ();
			public string get_head_param (string head, string name);
			public edwinspire.uHttp.MultiPartFormDataHeader get_header_content_disposition ();
			public edwinspire.uHttp.MultiPartFormDataHeader get_header_for_name (string name);
			public Gee.ArrayList<edwinspire.uHttp.MultiPartFormDataHeader> Headers { get; set; }
			public uint8[] data { get; set; }
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "", nick = "HTTP Request")]
		public class Request : GLib.Object {
			public Request ();
			public void from_lines (string lines);
			public void print ();
			public int ContentLength { get; }
			public uint8[] Data { get; set; }
			[Description (blurb = "Content sent by User Agent from POST", nick = "Content Form")]
			public Gee.HashMap<string,string> Form { get; private set; }
			public Gee.HashMap<string,string> Header { get; private set; }
			public edwinspire.uHttp.RequestMethod Method { get; private set; }
			public edwinspire.uHttp.MultiPartFormData MultiPartForm { get; private set; }
			public string Path { get; private set; }
			[Description (blurb = "Query pased by url, Method GET", nick = "Query")]
			public Gee.HashMap<string,string> Query { get; private set; }
			public bool isWebSocketHandshake { get; private set; }
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "Response from server", nick = "HTTP Response")]
		public class Response : GLib.Object {
			public uint8[] Data;
			public Gee.HashMap<string,string> Header;
			public edwinspire.uHttp.StatusCode Status;
			public Response ();
			public static string HtmErrorPage (string title = "uHTTP WebServer", string error);
			public string ToString ();
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		public class TemporaryVariables : GLib.Object {
			public TemporaryVariables ();
			public string get_value (string n);
			public void set_value (string n, string v, int t = 10);
			public string set_value_random_name (string v, int t = 10);
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "Micro embebed HTTP Web Server", nick = "HTTP Server")]
		public class uHttpServer : GLib.Object {
			[Description (blurb = " Data Config uHTTP", nick = "Config uHTTP")]
			public edwinspire.uHttp.uHttpServerConfig Config;
			public edwinspire.uHttp.TemporaryVariables TempGlobalVars;
			public int heartbeatseconds;
			[Description (blurb = "", nick = "Constructor uHttpServer")]
			public uHttpServer (int max_threads = 100);
			public static string EnumToXml (GLib.Type typeenum, bool fieldtextasbase64 = true);
			[Description (blurb = "Crea una Url unica automaticamente", nick = "GenUrl")]
			public static string GenUrl (string root = "/", string value = "Sf54+-dsfk%6md&bfpJ");
			public static uint8[] LoadFile (string Path);
			public uint8[] LoadServerFile (string path);
			public string PathLocalFile (string Filex);
			public static string ReadFile (string path);
			public string ReadServerFile (string path);
			public virtual bool connection_handler_virtual (edwinspire.uHttp.Request request, GLib.DataOutputStream dos);
			public static string get_data_as_string_valid_unichars (uint8[] d);
			public static string get_extension_file (string file_name);
			[Description (blurb = "Run on MainLoop", nick = "Run Server")]
			public virtual void run ();
			public void run_without_mainloop ();
			public static bool save_file (string path, uint8[] data, bool replace = false);
			public long sendEvent (string data, GLib.DataOutputStream dos);
			public void sendEventHeader (GLib.DataOutputStream dos);
			[Description (blurb = "", nick = "Server Response")]
			public void serve_response (edwinspire.uHttp.Response response, GLib.DataOutputStream dos);
			public bool upload_file (string subpath_file, uint8[] data, bool replace = false);
			public long writeData (uint8[] data_, GLib.DataOutputStream dos);
			[Description (blurb = "Señal se dispara cuando una página no es encontrada en el servidor", nick = "Signal Request URL No Found")]
			public signal void NoFoundURL (edwinspire.uHttp.Request request);
			public signal void heartbeat (int seconds);
		}
		[CCode (cheader_filename = "libspire_uhttp.h")]
		[Description (blurb = "Micro embebed HTTP Web Server config file", nick = "HTTP Server Config")]
		public class uHttpServerConfig : GLib.Object {
			[Description (blurb = "Index page, default: index.html", nick = "Index")]
			public string Index;
			[Description (blurb = "Default: 8080", nick = "Port")]
			public uint16 Port;
			public bool RequestPrintOnConsole;
			[Description (blurb = "Default: rootweb on current directory.", nick = "Path Root")]
			public string Root;
			public uHttpServerConfig ();
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
			HEAD,
			PUT
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
