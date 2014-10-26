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

	/**
	* Support PHP scripts
	* Create php wath define variables
	*/
	public class PHP_Support:FileFunctions{
		
		public string Server_Addr = "Undefined";
		public string Server_Name = "uHTTP";
		public string Server_Software = VERSION;
		public string Server_Protocol = "HTTP/1.0";
		//public string Path_Uploads = "";
		//public string DocumentRoot = "";
		public PHP_Support(){
			this.file_name = "set_php_vars_uhttp.php";
			string default_message = """<?php
eval($argv[2]);
include_once $argv[1];
?>""";
			this.write_file(default_message.data, false);
		}

		/**
		* Is Script PHP
		* For uhttp have partial support of PHP without problems the script name must have the following format: * -xml.php . In this case xml tells the library to the format returned by the script will be xml , this way you can use any Mimetype.
		*/
		public static bool is_script(string file, ref string new_name){
			bool R = false;
		//warning ("\nScript %s\n", file);
			try {
				Regex RegExp = new Regex("""([\w|0-9|-|_|/|\\]+)-(?<ext>[\w]+).php""");
				MatchInfo match;
				if(RegExp.match(file, RegexMatchFlags.ANCHORED, out match)) {
		//		warning ("Si es un script php valido/n");
					R = true;
					new_name = "script_php."+match.fetch_named("ext");
				}else{
					if(file.has_suffix(".php")){
						new_name = "script_php.php";
						R = true;
					}
				}				
			}catch (RegexError err) {
				warning (err.message);
			}
		
		
			return R;
		}
		
		private string get_vars_from_query(HashMap<string, string> query){
			var s = new StringBuilder();
			
			foreach(var q in query.entries){
			s.append_printf("$_uHTTP_GET['%s'] = \"%s\"; ", q.key, q.value.replace("\"", """\""""));			
			}
			return s.str;
		}
		
		private string get_vars_from_post(HashMap<string, string> post){
			var s = new StringBuilder();
			
			foreach(var q in post.entries){
			s.append_printf("$_uHTTP_POST['%s'] = \"%s\"; ", q.key, q.value.replace("\"", """\""""));			
			}
			return s.str;
		}
		
		private string headers_vars_from_request_headers(HashMap<string, string> headers){
			var s = new StringBuilder();
			
			foreach(var h in headers.entries){
			s.append_printf("$_SERVER['HTTP_%s'] = \"%s\"; ", h.key.up().replace("-", "_"), h.value.replace("\"", """\""""));			
			}
			return s.str;		
		}
		
		public string run_script(string script, string document_root, string tmp_dir, ref Request request){
		var Salida = new  StringBuilder("php -f ");
		Salida.append_printf("%s ", this.file_name);

			try{		
		var arguments = new StringBuilder();
		arguments.append_printf("$_SERVER[\'SERVER_ADDR\'] = \"%s\"; $_SERVER[\'SERVER_NAME\'] = \"%s\"; $_SERVER[\'SERVER_SOFTWARE\'] = \"%s\"; $_SERVER[\'SERVER_PROTOCOL\'] = \"%s\"; $_SERVER[\'SERVER_METHOD\'] = \"%s\"; $_SERVER[\'UHTTP_UPLOAD_TEMP_DIR\'] = \"%s\"; $_SERVER[\'DOCUMENT_ROOT\'] = \"%s\";", Server_Addr, Server_Name, Server_Software, Server_Protocol, (request.Method.to_string()).replace("EDWINSPIRE_UHTTP_REQUEST_METHOD_", ""), tmp_dir, document_root);
				
		#if (_WIN_SPIRE_)
		// TODO: Por definir, no está probado
	//	Posix.system(Funtions.Quote(Shell.unquote(script), true));
		#endif

		#if (_LNX_SPIRE_)
		string standard_output;
		string standard_error;
		Salida.append_printf("%s ", script);	
		arguments.append_printf("%s ", this.headers_vars_from_request_headers(request.Header));
		arguments.append_printf("%s ", this.get_vars_from_query(request.Form.get_request.as_hasmap()));		
		arguments.append_printf("%s ", this.get_vars_from_post(request.Form.post_request.as_hasmap()));										
		Salida.append_printf("%s", Shell.quote(arguments.str));		
		
			
				stderr.printf("Ejecutando script %s\n",Salida.str);
				Process.spawn_command_line_sync (Salida.str, out standard_output, out standard_error);
				stderr.printf("%s\n", standard_error);
				Salida.truncate();
				Salida.append(standard_output);
		#endif				
			}

			catch(SpawnError e){
				GLib.stderr.printf("run_script error %s\n", e.message);
			}

		return Salida.str;
		}
	}


}
