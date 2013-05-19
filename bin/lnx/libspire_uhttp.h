/* libspire_uhttp.h generated by valac 0.16.1, the Vala compiler, do not modify */


#ifndef ___HOME_EDWINSPIRE_PROGRAMACION_PROYECTOSSOFTWARE_SOFTWARE_VALA_PROYECTOSVALA_PROYECTS_LIBSPIRE_UHTTP_BIN_LNX_LIBSPIRE_UHTTP_H__
#define ___HOME_EDWINSPIRE_PROGRAMACION_PROYECTOSSOFTWARE_SOFTWARE_VALA_PROYECTOSVALA_PROYECTS_LIBSPIRE_UHTTP_BIN_LNX_LIBSPIRE_UHTTP_H__

#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>
#include <gee.h>
#include <gio/gio.h>

G_BEGIN_DECLS


#define EDWINSPIRE_UHTTP_TYPE_HTTP_VERSION (edwinspire_uhttp_http_version_get_type ())

#define EDWINSPIRE_UHTTP_TYPE_STATUS_CODE (edwinspire_uhttp_status_code_get_type ())

#define EDWINSPIRE_UHTTP_TYPE_REQUEST_METHOD (edwinspire_uhttp_request_method_get_type ())

#define EDWINSPIRE_UHTTP_TYPE_FORM (edwinspire_uhttp_form_get_type ())
#define EDWINSPIRE_UHTTP_FORM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_FORM, edwinspireuHttpForm))
#define EDWINSPIRE_UHTTP_FORM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_FORM, edwinspireuHttpFormClass))
#define EDWINSPIRE_UHTTP_IS_FORM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_FORM))
#define EDWINSPIRE_UHTTP_IS_FORM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_FORM))
#define EDWINSPIRE_UHTTP_FORM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_FORM, edwinspireuHttpFormClass))

typedef struct _edwinspireuHttpForm edwinspireuHttpForm;
typedef struct _edwinspireuHttpFormClass edwinspireuHttpFormClass;
typedef struct _edwinspireuHttpFormPrivate edwinspireuHttpFormPrivate;

#define EDWINSPIRE_UHTTP_TYPE_HEADER (edwinspire_uhttp_header_get_type ())
#define EDWINSPIRE_UHTTP_HEADER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_HEADER, edwinspireuHttpHeader))
#define EDWINSPIRE_UHTTP_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_HEADER, edwinspireuHttpHeaderClass))
#define EDWINSPIRE_UHTTP_IS_HEADER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_HEADER))
#define EDWINSPIRE_UHTTP_IS_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_HEADER))
#define EDWINSPIRE_UHTTP_HEADER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_HEADER, edwinspireuHttpHeaderClass))

typedef struct _edwinspireuHttpHeader edwinspireuHttpHeader;
typedef struct _edwinspireuHttpHeaderClass edwinspireuHttpHeaderClass;
typedef struct _edwinspireuHttpHeaderPrivate edwinspireuHttpHeaderPrivate;

#define EDWINSPIRE_UHTTP_TYPE_REQUEST_HEADER (edwinspire_uhttp_request_header_get_type ())
#define EDWINSPIRE_UHTTP_REQUEST_HEADER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_REQUEST_HEADER, edwinspireuHttpRequestHeader))
#define EDWINSPIRE_UHTTP_REQUEST_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_REQUEST_HEADER, edwinspireuHttpRequestHeaderClass))
#define EDWINSPIRE_UHTTP_IS_REQUEST_HEADER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_REQUEST_HEADER))
#define EDWINSPIRE_UHTTP_IS_REQUEST_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_REQUEST_HEADER))
#define EDWINSPIRE_UHTTP_REQUEST_HEADER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_REQUEST_HEADER, edwinspireuHttpRequestHeaderClass))

typedef struct _edwinspireuHttpRequestHeader edwinspireuHttpRequestHeader;
typedef struct _edwinspireuHttpRequestHeaderClass edwinspireuHttpRequestHeaderClass;
typedef struct _edwinspireuHttpRequestHeaderPrivate edwinspireuHttpRequestHeaderPrivate;

#define EDWINSPIRE_UHTTP_TYPE_RESPONSE_HEADER (edwinspire_uhttp_response_header_get_type ())
#define EDWINSPIRE_UHTTP_RESPONSE_HEADER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_RESPONSE_HEADER, edwinspireuHttpResponseHeader))
#define EDWINSPIRE_UHTTP_RESPONSE_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_RESPONSE_HEADER, edwinspireuHttpResponseHeaderClass))
#define EDWINSPIRE_UHTTP_IS_RESPONSE_HEADER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_RESPONSE_HEADER))
#define EDWINSPIRE_UHTTP_IS_RESPONSE_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_RESPONSE_HEADER))
#define EDWINSPIRE_UHTTP_RESPONSE_HEADER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_RESPONSE_HEADER, edwinspireuHttpResponseHeaderClass))

typedef struct _edwinspireuHttpResponseHeader edwinspireuHttpResponseHeader;
typedef struct _edwinspireuHttpResponseHeaderClass edwinspireuHttpResponseHeaderClass;
typedef struct _edwinspireuHttpResponseHeaderPrivate edwinspireuHttpResponseHeaderPrivate;

#define EDWINSPIRE_UHTTP_TYPE_REQUEST (edwinspire_uhttp_request_get_type ())
#define EDWINSPIRE_UHTTP_REQUEST(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_REQUEST, edwinspireuHttpRequest))
#define EDWINSPIRE_UHTTP_REQUEST_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_REQUEST, edwinspireuHttpRequestClass))
#define EDWINSPIRE_UHTTP_IS_REQUEST(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_REQUEST))
#define EDWINSPIRE_UHTTP_IS_REQUEST_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_REQUEST))
#define EDWINSPIRE_UHTTP_REQUEST_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_REQUEST, edwinspireuHttpRequestClass))

typedef struct _edwinspireuHttpRequest edwinspireuHttpRequest;
typedef struct _edwinspireuHttpRequestClass edwinspireuHttpRequestClass;
typedef struct _edwinspireuHttpRequestPrivate edwinspireuHttpRequestPrivate;

#define EDWINSPIRE_UHTTP_TYPE_RESPONSE (edwinspire_uhttp_response_get_type ())
#define EDWINSPIRE_UHTTP_RESPONSE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_RESPONSE, edwinspireuHttpResponse))
#define EDWINSPIRE_UHTTP_RESPONSE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_RESPONSE, edwinspireuHttpResponseClass))
#define EDWINSPIRE_UHTTP_IS_RESPONSE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_RESPONSE))
#define EDWINSPIRE_UHTTP_IS_RESPONSE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_RESPONSE))
#define EDWINSPIRE_UHTTP_RESPONSE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_RESPONSE, edwinspireuHttpResponseClass))

typedef struct _edwinspireuHttpResponse edwinspireuHttpResponse;
typedef struct _edwinspireuHttpResponseClass edwinspireuHttpResponseClass;
typedef struct _edwinspireuHttpResponsePrivate edwinspireuHttpResponsePrivate;

#define EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONGIF (edwinspire_uhttp_uhttp_server_congif_get_type ())
#define EDWINSPIRE_UHTTP_UHTTP_SERVER_CONGIF(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONGIF, edwinspireuHttpuHttpServerCongif))
#define EDWINSPIRE_UHTTP_UHTTP_SERVER_CONGIF_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONGIF, edwinspireuHttpuHttpServerCongifClass))
#define EDWINSPIRE_UHTTP_IS_UHTTP_SERVER_CONGIF(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONGIF))
#define EDWINSPIRE_UHTTP_IS_UHTTP_SERVER_CONGIF_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONGIF))
#define EDWINSPIRE_UHTTP_UHTTP_SERVER_CONGIF_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONGIF, edwinspireuHttpuHttpServerCongifClass))

typedef struct _edwinspireuHttpuHttpServerCongif edwinspireuHttpuHttpServerCongif;
typedef struct _edwinspireuHttpuHttpServerCongifClass edwinspireuHttpuHttpServerCongifClass;
typedef struct _edwinspireuHttpuHttpServerCongifPrivate edwinspireuHttpuHttpServerCongifPrivate;

#define EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER (edwinspire_uhttp_uhttp_server_get_type ())
#define EDWINSPIRE_UHTTP_UHTTP_SERVER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER, edwinspireuHttpuHttpServer))
#define EDWINSPIRE_UHTTP_UHTTP_SERVER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER, edwinspireuHttpuHttpServerClass))
#define EDWINSPIRE_UHTTP_IS_UHTTP_SERVER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER))
#define EDWINSPIRE_UHTTP_IS_UHTTP_SERVER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER))
#define EDWINSPIRE_UHTTP_UHTTP_SERVER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER, edwinspireuHttpuHttpServerClass))

typedef struct _edwinspireuHttpuHttpServer edwinspireuHttpuHttpServer;
typedef struct _edwinspireuHttpuHttpServerClass edwinspireuHttpuHttpServerClass;
typedef struct _edwinspireuHttpuHttpServerPrivate edwinspireuHttpuHttpServerPrivate;

typedef enum  {
	EDWINSPIRE_UHTTP_HTTP_VERSION_1_0,
	EDWINSPIRE_UHTTP_HTTP_VERSION_1_1
} edwinspireuHttpHTTPVersion;

typedef enum  {
	EDWINSPIRE_UHTTP_STATUS_CODE_NONE,
	EDWINSPIRE_UHTTP_STATUS_CODE_CONTINUE,
	EDWINSPIRE_UHTTP_STATUS_CODE_SWITCHING_PROTOCOLS,
	EDWINSPIRE_UHTTP_STATUS_CODE_PROCESSING,
	EDWINSPIRE_UHTTP_STATUS_CODE_OK,
	EDWINSPIRE_UHTTP_STATUS_CODE_CREATED,
	EDWINSPIRE_UHTTP_STATUS_CODE_ACCEPTED,
	EDWINSPIRE_UHTTP_STATUS_CODE_NON_AUTHORITATIVE,
	EDWINSPIRE_UHTTP_STATUS_CODE_NO_CONTENT,
	EDWINSPIRE_UHTTP_STATUS_CODE_RESET_CONTENT,
	EDWINSPIRE_UHTTP_STATUS_CODE_PARTIAL_CONTENT,
	EDWINSPIRE_UHTTP_STATUS_CODE_MULTI_STATUS,
	EDWINSPIRE_UHTTP_STATUS_CODE_MULTIPLE_CHOICES,
	EDWINSPIRE_UHTTP_STATUS_CODE_MOVED_PERMANENTLY,
	EDWINSPIRE_UHTTP_STATUS_CODE_FOUND,
	EDWINSPIRE_UHTTP_STATUS_CODE_MOVED_TEMPORARILY,
	EDWINSPIRE_UHTTP_STATUS_CODE_SEE_OTHER,
	EDWINSPIRE_UHTTP_STATUS_CODE_NOT_MODIFIED,
	EDWINSPIRE_UHTTP_STATUS_CODE_USE_PROXY,
	EDWINSPIRE_UHTTP_STATUS_CODE_NOT_APPEARING_IN_THIS_PROTOCOL,
	EDWINSPIRE_UHTTP_STATUS_CODE_TEMPORARY_REDIRECT,
	EDWINSPIRE_UHTTP_STATUS_CODE_BAD_REQUEST,
	EDWINSPIRE_UHTTP_STATUS_CODE_UNAUTHORIZED,
	EDWINSPIRE_UHTTP_STATUS_CODE_PAYMENT_REQUIRED,
	EDWINSPIRE_UHTTP_STATUS_CODE_FORBIDDEN,
	EDWINSPIRE_UHTTP_STATUS_CODE_NOT_FOUND,
	EDWINSPIRE_UHTTP_STATUS_CODE_METHOD_NOT_ALLOWED,
	EDWINSPIRE_UHTTP_STATUS_CODE_NOT_ACCEPTABLE,
	EDWINSPIRE_UHTTP_STATUS_CODE_PROXY_AUTHENTICATION_REQUIRED,
	EDWINSPIRE_UHTTP_STATUS_CODE_PROXY_UNAUTHORIZED,
	EDWINSPIRE_UHTTP_STATUS_CODE_REQUEST_TIMEOUT,
	EDWINSPIRE_UHTTP_STATUS_CODE_CONFLICT,
	EDWINSPIRE_UHTTP_STATUS_CODE_GONE,
	EDWINSPIRE_UHTTP_STATUS_CODE_LENGTH_REQUIRED,
	EDWINSPIRE_UHTTP_STATUS_CODE_PRECONDITION_FAILED,
	EDWINSPIRE_UHTTP_STATUS_CODE_REQUEST_ENTITY_TOO_LARGE,
	EDWINSPIRE_UHTTP_STATUS_CODE_REQUEST_URI_TOO_LONG,
	EDWINSPIRE_UHTTP_STATUS_CODE_UNSUPPORTED_MEDIA_TYPE,
	EDWINSPIRE_UHTTP_STATUS_CODE_REQUESTED_RANGE_NOT_SATISFIABLE,
	EDWINSPIRE_UHTTP_STATUS_CODE_INVALID_RANGE,
	EDWINSPIRE_UHTTP_STATUS_CODE_EXPECTATION_FAILED,
	EDWINSPIRE_UHTTP_STATUS_CODE_UNPROCESSABLE_ENTITY,
	EDWINSPIRE_UHTTP_STATUS_CODE_LOCKED,
	EDWINSPIRE_UHTTP_STATUS_CODE_FAILED_DEPENDENCY,
	EDWINSPIRE_UHTTP_STATUS_CODE_INTERNAL_SERVER_ERROR,
	EDWINSPIRE_UHTTP_STATUS_CODE_NOT_IMPLEMENTED,
	EDWINSPIRE_UHTTP_STATUS_CODE_BAD_GATEWAY,
	EDWINSPIRE_UHTTP_STATUS_CODE_SERVICE_UNAVAILABLE,
	EDWINSPIRE_UHTTP_STATUS_CODE_GATEWAY_TIMEOUT,
	EDWINSPIRE_UHTTP_STATUS_CODE_HTTP_VERSION_NOT_SUPPORTED,
	EDWINSPIRE_UHTTP_STATUS_CODE_INSUFFICIENT_STORAGE,
	EDWINSPIRE_UHTTP_STATUS_CODE_NOT_EXTENDED
} edwinspireuHttpStatusCode;

typedef enum  {
	EDWINSPIRE_UHTTP_REQUEST_METHOD_UNKNOW,
	EDWINSPIRE_UHTTP_REQUEST_METHOD_GET,
	EDWINSPIRE_UHTTP_REQUEST_METHOD_POST,
	EDWINSPIRE_UHTTP_REQUEST_METHOD_HEAD
} edwinspireuHttpRequestMethod;

struct _edwinspireuHttpForm {
	GObject parent_instance;
	edwinspireuHttpFormPrivate * priv;
};

struct _edwinspireuHttpFormClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpHeader {
	GObject parent_instance;
	edwinspireuHttpHeaderPrivate * priv;
	gchar* CacheControl;
	gchar* Connection;
	gchar* ContentEncoding;
	gchar* ContentLenguaje;
	gint ContentLength;
	gchar* ContentLocation;
	gchar* ContentMD5;
	gchar* ContentRange;
	gchar* ContentType;
	gchar* Date;
	gchar* Expires;
	gchar* LastModified;
	gchar* Pragma;
	gchar* Range;
	gchar* Trailer;
	gchar* TransferEncoding;
	gchar* Upgrade;
	gchar* Via;
	gchar* Warning;
	gchar* HttpVersion;
};

struct _edwinspireuHttpHeaderClass {
	GObjectClass parent_class;
	void (*print) (edwinspireuHttpHeader* self);
	gchar* (*ToString) (edwinspireuHttpHeader* self);
};

struct _edwinspireuHttpRequestHeader {
	edwinspireuHttpHeader parent_instance;
	edwinspireuHttpRequestHeaderPrivate * priv;
	gchar* Accept;
	gchar* AcceptCharset;
	gchar* AcceptEncoding;
	gchar* AcceptLanguage;
	gchar* Autorization;
	gchar* Except;
	gchar* From;
	gchar* Host;
	gchar* IfMatch;
	gchar* IfModifiedSince;
	gchar* IfNoneMatch;
	gchar* IfRange;
	gchar* IfUnmodifiedSince;
	gchar* MaxFordwards;
	gchar* ProxyAutorization;
	gchar* Referer;
	gchar* TE;
	gchar* UserAgent;
	gchar* Vary;
};

struct _edwinspireuHttpRequestHeaderClass {
	edwinspireuHttpHeaderClass parent_class;
};

struct _edwinspireuHttpResponseHeader {
	edwinspireuHttpHeader parent_instance;
	edwinspireuHttpResponseHeaderPrivate * priv;
	gchar* AcceptRanges;
	gchar* Age;
	gchar* ETag;
	gchar* Location;
	gchar* ProxyAuthenticate;
	gchar* RetryAfter;
	gchar* Server;
	gchar* WWWAuthenticate;
	edwinspireuHttpStatusCode Status;
};

struct _edwinspireuHttpResponseHeaderClass {
	edwinspireuHttpHeaderClass parent_class;
};

struct _edwinspireuHttpRequest {
	GObject parent_instance;
	edwinspireuHttpRequestPrivate * priv;
	edwinspireuHttpRequestMethod Method;
	gchar* Path;
	GeeHashMap* Query;
	edwinspireuHttpRequestHeader* Header;
};

struct _edwinspireuHttpRequestClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpResponse {
	GObject parent_instance;
	edwinspireuHttpResponsePrivate * priv;
	guint8* Data;
	gint Data_length1;
	edwinspireuHttpResponseHeader* Header;
};

struct _edwinspireuHttpResponseClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpuHttpServerCongif {
	GObject parent_instance;
	edwinspireuHttpuHttpServerCongifPrivate * priv;
	guint16 Port;
	gchar* Index;
	gboolean RequestPrintOnConsole;
	GeeHashMap* VirtualUrl;
	gchar* Root;
};

struct _edwinspireuHttpuHttpServerCongifClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpuHttpServer {
	GObject parent_instance;
	edwinspireuHttpuHttpServerPrivate * priv;
	edwinspireuHttpuHttpServerCongif* Config;
	GeeHashMap* VirtualUrl;
};

struct _edwinspireuHttpuHttpServerClass {
	GObjectClass parent_class;
};


GType edwinspire_uhttp_http_version_get_type (void) G_GNUC_CONST;
GType edwinspire_uhttp_status_code_get_type (void) G_GNUC_CONST;
GType edwinspire_uhttp_request_method_get_type (void) G_GNUC_CONST;
GType edwinspire_uhttp_form_get_type (void) G_GNUC_CONST;
edwinspireuHttpForm* edwinspire_uhttp_form_new (void);
edwinspireuHttpForm* edwinspire_uhttp_form_construct (GType object_type);
GeeHashMap* edwinspire_uhttp_form_DataDecode (const gchar* data);
GType edwinspire_uhttp_header_get_type (void) G_GNUC_CONST;
edwinspireuHttpHeader* edwinspire_uhttp_header_new (void);
edwinspireuHttpHeader* edwinspire_uhttp_header_construct (GType object_type);
void edwinspire_uhttp_header_print (edwinspireuHttpHeader* self);
gchar* edwinspire_uhttp_header_ToString (edwinspireuHttpHeader* self);
GType edwinspire_uhttp_request_header_get_type (void) G_GNUC_CONST;
edwinspireuHttpRequestHeader* edwinspire_uhttp_request_header_new (void);
edwinspireuHttpRequestHeader* edwinspire_uhttp_request_header_construct (GType object_type);
GType edwinspire_uhttp_response_header_get_type (void) G_GNUC_CONST;
edwinspireuHttpResponseHeader* edwinspire_uhttp_response_header_new (void);
edwinspireuHttpResponseHeader* edwinspire_uhttp_response_header_construct (GType object_type);
gchar* edwinspire_uhttp_response_header_StatusString (edwinspireuHttpResponseHeader* self);
gchar* edwinspire_uhttp_response_header_HtmlStatusCode (edwinspireuHttpStatusCode sc);
GType edwinspire_uhttp_request_get_type (void) G_GNUC_CONST;
edwinspireuHttpRequest* edwinspire_uhttp_request_new (void);
edwinspireuHttpRequest* edwinspire_uhttp_request_construct (GType object_type);
void edwinspire_uhttp_request_print (edwinspireuHttpRequest* self);
GeeHashMap* edwinspire_uhttp_request_get_Form (edwinspireuHttpRequest* self);
guint8* edwinspire_uhttp_request_get_Data (edwinspireuHttpRequest* self, int* result_length1);
void edwinspire_uhttp_request_set_Data (edwinspireuHttpRequest* self, guint8* value, int value_length1);
GType edwinspire_uhttp_response_get_type (void) G_GNUC_CONST;
edwinspireuHttpResponse* edwinspire_uhttp_response_new (void);
edwinspireuHttpResponse* edwinspire_uhttp_response_construct (GType object_type);
gchar* edwinspire_uhttp_response_ToString (edwinspireuHttpResponse* self);
GType edwinspire_uhttp_uhttp_server_congif_get_type (void) G_GNUC_CONST;
edwinspireuHttpuHttpServerCongif* edwinspire_uhttp_uhttp_server_congif_new (void);
edwinspireuHttpuHttpServerCongif* edwinspire_uhttp_uhttp_server_congif_construct (GType object_type);
void edwinspire_uhttp_uhttp_server_congif_read (edwinspireuHttpuHttpServerCongif* self);
gchar* edwinspire_uhttp_uhttp_server_congif_ToXml (edwinspireuHttpuHttpServerCongif* self, gboolean fieldtextasbase64);
gboolean edwinspire_uhttp_uhttp_server_congif_write (edwinspireuHttpuHttpServerCongif* self);
GType edwinspire_uhttp_uhttp_server_get_type (void) G_GNUC_CONST;
edwinspireuHttpuHttpServer* edwinspire_uhttp_uhttp_server_new (gint max_threads);
edwinspireuHttpuHttpServer* edwinspire_uhttp_uhttp_server_construct (GType object_type, gint max_threads);
void edwinspire_uhttp_uhttp_server_run (edwinspireuHttpuHttpServer* self);
void edwinspire_uhttp_uhttp_server_run_without_mainloop (edwinspireuHttpuHttpServer* self);
gchar* edwinspire_uhttp_uhttp_server_GenUrl (const gchar* root, const gchar* value);
void edwinspire_uhttp_uhttp_server_serve_response (edwinspireuHttpuHttpServer* self, edwinspireuHttpResponse* response, GDataOutputStream* dos);
guint8* edwinspire_uhttp_uhttp_server_LoadFile (const gchar* Path, int* result_length1);


G_END_DECLS

#endif
