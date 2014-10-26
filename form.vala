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
	* POSTMultipartBlock
	* 
	*/
	public class POSTMultipartBlock:GLib.Object{

		public HashMap<string, string> Header{private set; get; default = new HashMap<string, string>();}
		public HashMap<string, string> Params{private set; get; default = new HashMap<string, string>();}
		private BinaryData binary = new BinaryData();
		public string path_file_tmp = "";
		
		public signal void file_uploaded(BinaryData bin, string filename);
		
		public POSTMultipartBlock(){
			
		}
		
		/**
		* All values
		* Returns all values ​​as a Hashmap
		*/
		public HashMap<string, string> all_values(){
			var r = new HashMap<string, string>();
			r.set_all(this.Header);
			r.set_all(this.Params);
			r.set("data_md5", this.binary.md5());
			r.set("data_length", this.binary.length.to_string());
			r.set("data_string", this.Value());	
			return r;
		}
		
		/**
		* Name
		* Block name
		*/
		public string Name(){
				if(Params.has_key("name")){
				return Params["name"];
				}else{
				return "";
				}
		}
		/**
		* Filename
		* If the block contains a file returns the file name, otherwise it returns an empty string .
		*/
		public string Filename(){
				if(Params.has_key("filename")){
				this.Params["tmp_full_path"] = Path.build_path (Path.DIR_SEPARATOR_S, this.path_file_tmp, binary.md5()+".tmp");
				return  Params["filename"];
				}else{
				return "";
				}
				
		}
		
		/**
		* Value
		* Returns the value of the block if the block corresponds to a file and returns the file name .
		*/
		public string Value(){
				if(Params.has_key("filename")){
				return  Params["filename"];
				}else{
				return this.binary.to_string_only_valid_unichars();
				}
				
		}
		
		/**
		* Create DataInputStream
		* Creates a DataInputStream from the data passed as a parameter .
		*/
		public static DataInputStream create_DataInputStream_from_data(uint8[] data){
		
			MemoryInputStream Mis = new MemoryInputStream.from_data(data, null);
			var dis = new DataInputStream(Mis);
			dis.set_buffer_size(data.length);
			return dis;
		}
		
		/**
		* Decode
		* 
		*/
		public void decode(uint8[] block){
		
					try{
		
		
			//MemoryInputStream Mis = new MemoryInputStream.from_data(block, null);
			var dis = create_DataInputStream_from_data(block);
			//dis.set_buffer_size(block.length);
			
				string line;
				//size_t ix = 0;
				
				while((line = dis.read_line(null)) != null){
				
				if(line == "\r"){
					//warning("Empieza datos %s\n", dis.get_available().to_string());
					break;
				}						
		
					
					Regex RxHeader = new Regex("""(?<header>[\w+\-]+): (?<value>[\w\-\/|:|=|;|\"|\s|.]+)""");
					Regex RxHeaderParameter = new Regex("""\s?(?<key>[\w+\-]+)="(?<value>[ \s\w\W\d\D]+)"""+"\"");
					MatchInfo matchH;
					if(RxHeader.match(line, RegexMatchFlags.ANCHORED, out matchH)) {
									// Sin parametros
						string k = "";
						string v = "";
									
						if(matchH.fetch_named("header") != null){		
							k = matchH.fetch_named("header");			
						}
						if(matchH.fetch_named("value") != null){		
							v = matchH.fetch_named("value");			
						}	
							
							this.Header[k] = v;		
								
						var params_header = v.split(";"); 		
							foreach	(var p in params_header){
						MatchInfo matchParam;
					if(RxHeaderParameter.match(p, RegexMatchFlags.ANCHORED, out matchParam)) {
								
						if(matchParam.fetch_named("key") != null){		
							k = matchParam.fetch_named("key");			
						}
						if(matchParam.fetch_named("value") != null){		
							v = matchParam.fetch_named("value");			
						}
						
						if(k.length>0){
							this.Params[k] = v;						
						}
					
					}		
							
							}	
									
									
								}
					
					
					}
					
			 uint8[] buffer = new uint8[dis.get_available()-2];
        		
        		dis.read (buffer);
        		this.binary.data = buffer;
		if(this.Filename().length>0){
		this.file_uploaded(this.binary, this.Filename());
		}		
					
					}catch(Error e){
						stderr.printf("\n%s\n", e.message);
					}		
			 //i++;

		}

	}

	public interface iFormValues:GLib.Object{
		public abstract HashMap<string, string> internal_hashmap{private set; get;} 
	
		public string set_value(string name, string value){
			string n = this.next_name_free(name);
			this.internal_hashmap[n] = value;
			return n;
		}
		
		public void set_value_direct(string name, string value){
			this.internal_hashmap[name] = value;
		}
		
		/**
		* Next name free
		* Gets the next free name that can be used .
		*/
		public string next_name_free(string name){
		
			var n = new StringBuilder();
			var i = 0;
			while(i < 100){
			n.truncate();
			n.append_printf("%s.%i", name, i);
			
				if(!internal_hashmap.has_key(n.str)){
				//	stderr.printf("--------- : %s\n%s\n", n.str, value);		
					//internal_hashmap[n.str] = value;
					break;
				}
			
			i++;
			}
			return n.str;
		}
		
		/**
		* Get value
		* Get value from name and index
		*/
		public string get_value(string name, int i = 0){
			string R = "";
			if(this.has_key(name, i)){
				R = internal_hashmap[name+"."+i.to_string()];
			}
						
		return R;
		}
		
		
		/**
		* Has key
		* Check if the name and index as parameters are passed.
		*/
		public bool has_key(string name, int i = 0){
			var n = new StringBuilder();
			n.append_printf("%s.%i", name, i);
			return internal_hashmap.has_key(n.str);
		}
		
		/**
		* Has HashMap
		* Returns all values ​​as a Hashmap
		*/
		public HashMap<string, string> as_hasmap(){
			return this.internal_hashmap;		
		}
		
		
		public string to_string(){
			var R = new StringBuilder();
			foreach(var reg in this.internal_hashmap.entries){
			R.append_printf("%s = %s\n", reg.key, reg.value);
			}
		return R.str;		
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
		
		
	}

	/**
	* GET
	* 
	*/
	public class GET:iFormValues, GLib.Object{
		public HashMap<string, string> internal_hashmap{private set; get; default = new HashMap<string, string>();}	
		public GET(){
				
		}
		/**
		* Decode
		* Decodes the data sent by the GET method
		*/
		public void decode(string query_section){
		//stderr.printf("decode:\n\n%s\n", query_section);		
				foreach(var part in query_section.split("&")) {
					//stderr.printf("--------- part:\n%s\n", part);		
					var kv = part.split("=");
						if(kv.length>1) {
							string Key = Uri.unescape_string(kv[0].replace("+", " "));
							string Value = Uri.unescape_string(kv[1].replace("+", " "));
							this.set_value(Key, Value);
								}
				}
		}
	
	}

	/**
	* POST
	*
	*/
	public class POST:iFormValues, GLib.Object{
		public HashMap<string, string> internal_hashmap{private set; get; default = new HashMap<string, string>();}
		public bool is_multipart_form_data {private set; get; default = false;}
		public signal void file_uploaded(BinaryData bin, string filename);
		public string path_file_tmp = "";
		/**
		* Boundary
		* The Content-Type field for multipart entities requires one parameter, "boundary", which is used to specify the encapsulation boundary. The encapsulation boundary is defined as a line consisting entirely of two hyphen characters ("-", decimal code 45) followed by the boundary parameter value from the Content-Type header field.
		*/
		[Description(nick = "Multi Part Form Boundary", blurb = "Boundary")]
		public string boundary {
			get;
			private set;
			default = "uHTTPServerxyzqwertyuiopasdf2f3g5h5j";
		}	
		public POST(){
				
		}
		
		/**
		* Decode
		* Decodes the data sent by the POST method
		*/
		public void decode(HashMap<string, string> header,  uint8[] data){
 			if(header.has_key("Content-Type")) {
 				// Verificamos si el formulario viene como multipart/form-data
				if(!this.decode_from_multipart(header["Content-Type"], data)){
					this.decode_from_simple(data);					
				}
			}
		}

		/**
		* Data from a form POST method with multipart 
		* Gets the form data sent with POST method with multipart 
		*/		
		private bool decode_from_multipart(string ContentTypeHeader, uint8[] data){
			this.is_multipart_form_data = false;
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
			
			if(this.is_multipart_form_data) {
				
				ArrayList<POSTMultipartBlock> blocks = this.blocks_multipart(data);
				foreach(var b in blocks){
				//b.all_values();
				string nblock = this.set_value(b.Name(), b.Value());
					var TempKey = new StringBuilder();
					var bk = b.all_values();
					foreach(var p in bk.entries){
						TempKey.append_printf("%s.%s", nblock, p.key);
						this.set_value_direct(TempKey.str, p.value);
						TempKey.truncate();							
					}
				
				//this.set_value(b.Name(), Value);
				}			
			}
			//stderr.printf("Decode as multipar\n%s\n", this.is_multipart_form_data.to_string());
		return this.is_multipart_form_data;
		}
		
		private ArrayList<POSTMultipartBlock> blocks_multipart(uint8[] data){
			
			size_t pos_block_end = 0;
			var blocks= new ArrayList<POSTMultipartBlock>();
			
			try{
			
			var dis = POSTMultipartBlock.create_DataInputStream_from_data(data);
			
				string line;
				size_t ix = 0;
				while((line = dis.read_line(null)) != null){
					//stdout.printf("[%s - %s]\n", dis.get_buffer_size().to_string(), dis.get_available().to_string());
					if(line.contains(this.boundary)){
						
						if(ix < 1){
							ix = data.length - dis.get_available();
							}else if(ix > 0){
							
							pos_block_end = data.length - dis.get_available() -1;
							
							var bytes = new Bytes(data[ix: pos_block_end]);
							blocks.add(this.decode_block(bytes.slice(0, bytes.length-line.data.length).get_data (), this.path_file_tmp));
							
							ix = data.length - dis.get_available();
						}
						
						
					}
				}
			
			}catch(Error e){
			warning(e.message);
			}
				
				
			
		return blocks; 		
		}
		
		
		private POSTMultipartBlock decode_block(uint8[] block, string pathfiletmp){
			POSTMultipartBlock PMPB = new POSTMultipartBlock();
			PMPB.path_file_tmp = pathfiletmp;
			PMPB.file_uploaded.connect(upload_file_signal);
			PMPB.decode(block); 
			return PMPB;
		}
		
		private void upload_file_signal(BinaryData binary, string filename){	
				this.file_uploaded(binary, filename);
		}
		
		/**
		* Data from a form POST method
		* Gets the form data sent with POST method
		*/
		private void decode_from_simple(uint8[] data){
			string? data_string = this.get_data_as_string_valid_unichars(data);
			if(data_string != null) {
				// Con la cadena formada la dividimos en bloques de datos, separados por &
				foreach(var Bloque in data_string.split("&")) {
					var KVx = Bloque.split("=");
					if(KVx.length==2) {
						string Key = Uri.unescape_string(KVx[0].replace("+", " "));
						string Value = Uri.unescape_string(KVx[1].replace("+", " "));
						this.set_value(Key, Value);
					}
				}
			}
		
		
		}
	
	}
	
	/**
	* Form Request
	* Class that extracts the data sent from a form with the Post or Get method .
	*/	
	public class FormRequest:GLib.Object{
		public GET get_request{private set; get; default = new GET();}
		public POST post_request{private set; get; default = new POST();}
		public string path_file_tmp = "";	
	
		public FormRequest(){
		
		}	
		
		public string to_string(){
		
		var s = new StringBuilder();
		s.append_printf("GET:\n%s\nPOST:\n%s\n", get_request.to_string(), post_request.to_string());
		return s.str;
		}
		
		
		public void decode(RequestMethod method, HashMap<string, string> header, string? query, uint8[] data){

			switch(method){
			
				case RequestMethod.POST:
					this.post_request.decode(header,  data);
				break;
				case RequestMethod.GET:
					this.get_request.decode(query);
				break;
			}
			
			
		
		}
	
	}


}
