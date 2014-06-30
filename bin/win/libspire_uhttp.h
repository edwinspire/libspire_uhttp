/* libspire_uhttp.h generated by valac 0.20.1, the Vala compiler, do not modify */


#ifndef __E__PROYECTS_LIBSPIRE_UHTTP_BIN_WIN_LIBSPIRE_UHTTP_H__
#define __E__PROYECTS_LIBSPIRE_UHTTP_BIN_WIN_LIBSPIRE_UHTTP_H__

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

#define EDWINSPIRE_UHTTP_TYPE_REQUEST (edwinspire_uhttp_request_get_type ())
#define EDWINSPIRE_UHTTP_REQUEST(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_REQUEST, edwinspireuHttpRequest))
#define EDWINSPIRE_UHTTP_REQUEST_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_REQUEST, edwinspireuHttpRequestClass))
#define EDWINSPIRE_UHTTP_IS_REQUEST(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_REQUEST))
#define EDWINSPIRE_UHTTP_IS_REQUEST_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_REQUEST))
#define EDWINSPIRE_UHTTP_REQUEST_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_REQUEST, edwinspireuHttpRequestClass))

typedef struct _edwinspireuHttpRequest edwinspireuHttpRequest;
typedef struct _edwinspireuHttpRequestClass edwinspireuHttpRequestClass;
typedef struct _edwinspireuHttpRequestPrivate edwinspireuHttpRequestPrivate;

#define EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA (edwinspire_uhttp_multi_part_form_data_get_type ())
#define EDWINSPIRE_UHTTP_MULTI_PART_FORM_DATA(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA, edwinspireuHttpMultiPartFormData))
#define EDWINSPIRE_UHTTP_MULTI_PART_FORM_DATA_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA, edwinspireuHttpMultiPartFormDataClass))
#define EDWINSPIRE_UHTTP_IS_MULTI_PART_FORM_DATA(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA))
#define EDWINSPIRE_UHTTP_IS_MULTI_PART_FORM_DATA_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA))
#define EDWINSPIRE_UHTTP_MULTI_PART_FORM_DATA_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA, edwinspireuHttpMultiPartFormDataClass))

typedef struct _edwinspireuHttpMultiPartFormData edwinspireuHttpMultiPartFormData;
typedef struct _edwinspireuHttpMultiPartFormDataClass edwinspireuHttpMultiPartFormDataClass;

#define EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_HEADER (edwinspire_uhttp_multi_part_form_data_header_get_type ())
#define EDWINSPIRE_UHTTP_MULTI_PART_FORM_DATA_HEADER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_HEADER, edwinspireuHttpMultiPartFormDataHeader))
#define EDWINSPIRE_UHTTP_MULTI_PART_FORM_DATA_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_HEADER, edwinspireuHttpMultiPartFormDataHeaderClass))
#define EDWINSPIRE_UHTTP_IS_MULTI_PART_FORM_DATA_HEADER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_HEADER))
#define EDWINSPIRE_UHTTP_IS_MULTI_PART_FORM_DATA_HEADER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_HEADER))
#define EDWINSPIRE_UHTTP_MULTI_PART_FORM_DATA_HEADER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_HEADER, edwinspireuHttpMultiPartFormDataHeaderClass))

typedef struct _edwinspireuHttpMultiPartFormDataHeader edwinspireuHttpMultiPartFormDataHeader;
typedef struct _edwinspireuHttpMultiPartFormDataHeaderClass edwinspireuHttpMultiPartFormDataHeaderClass;
typedef struct _edwinspireuHttpMultiPartFormDataHeaderPrivate edwinspireuHttpMultiPartFormDataHeaderPrivate;

#define EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_PART (edwinspire_uhttp_multi_part_form_data_part_get_type ())
#define EDWINSPIRE_UHTTP_MULTI_PART_FORM_DATA_PART(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_PART, edwinspireuHttpMultiPartFormDataPart))
#define EDWINSPIRE_UHTTP_MULTI_PART_FORM_DATA_PART_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_PART, edwinspireuHttpMultiPartFormDataPartClass))
#define EDWINSPIRE_UHTTP_IS_MULTI_PART_FORM_DATA_PART(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_PART))
#define EDWINSPIRE_UHTTP_IS_MULTI_PART_FORM_DATA_PART_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_PART))
#define EDWINSPIRE_UHTTP_MULTI_PART_FORM_DATA_PART_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_MULTI_PART_FORM_DATA_PART, edwinspireuHttpMultiPartFormDataPartClass))

typedef struct _edwinspireuHttpMultiPartFormDataPart edwinspireuHttpMultiPartFormDataPart;
typedef struct _edwinspireuHttpMultiPartFormDataPartClass edwinspireuHttpMultiPartFormDataPartClass;
typedef struct _edwinspireuHttpMultiPartFormDataPartPrivate edwinspireuHttpMultiPartFormDataPartPrivate;
typedef struct _edwinspireuHttpMultiPartFormDataPrivate edwinspireuHttpMultiPartFormDataPrivate;

#define EDWINSPIRE_UHTTP_TYPE_RESPONSE (edwinspire_uhttp_response_get_type ())
#define EDWINSPIRE_UHTTP_RESPONSE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_RESPONSE, edwinspireuHttpResponse))
#define EDWINSPIRE_UHTTP_RESPONSE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_RESPONSE, edwinspireuHttpResponseClass))
#define EDWINSPIRE_UHTTP_IS_RESPONSE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_RESPONSE))
#define EDWINSPIRE_UHTTP_IS_RESPONSE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_RESPONSE))
#define EDWINSPIRE_UHTTP_RESPONSE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_RESPONSE, edwinspireuHttpResponseClass))

typedef struct _edwinspireuHttpResponse edwinspireuHttpResponse;
typedef struct _edwinspireuHttpResponseClass edwinspireuHttpResponseClass;
typedef struct _edwinspireuHttpResponsePrivate edwinspireuHttpResponsePrivate;

#define EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONFIG (edwinspire_uhttp_uhttp_server_config_get_type ())
#define EDWINSPIRE_UHTTP_UHTTP_SERVER_CONFIG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONFIG, edwinspireuHttpuHttpServerConfig))
#define EDWINSPIRE_UHTTP_UHTTP_SERVER_CONFIG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONFIG, edwinspireuHttpuHttpServerConfigClass))
#define EDWINSPIRE_UHTTP_IS_UHTTP_SERVER_CONFIG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONFIG))
#define EDWINSPIRE_UHTTP_IS_UHTTP_SERVER_CONFIG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONFIG))
#define EDWINSPIRE_UHTTP_UHTTP_SERVER_CONFIG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_UHTTP_TYPE_UHTTP_SERVER_CONFIG, edwinspireuHttpuHttpServerConfigClass))

typedef struct _edwinspireuHttpuHttpServerConfig edwinspireuHttpuHttpServerConfig;
typedef struct _edwinspireuHttpuHttpServerConfigClass edwinspireuHttpuHttpServerConfigClass;
typedef struct _edwinspireuHttpuHttpServerConfigPrivate edwinspireuHttpuHttpServerConfigPrivate;

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
	EDWINSPIRE_UHTTP_REQUEST_METHOD_HEAD,
	EDWINSPIRE_UHTTP_REQUEST_METHOD_PUT
} edwinspireuHttpRequestMethod;

struct _edwinspireuHttpForm {
	GObject parent_instance;
	edwinspireuHttpFormPrivate * priv;
};

struct _edwinspireuHttpFormClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpRequest {
	GObject parent_instance;
	edwinspireuHttpRequestPrivate * priv;
};

struct _edwinspireuHttpRequestClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpMultiPartFormDataHeader {
	GObject parent_instance;
	edwinspireuHttpMultiPartFormDataHeaderPrivate * priv;
};

struct _edwinspireuHttpMultiPartFormDataHeaderClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpMultiPartFormDataPart {
	GObject parent_instance;
	edwinspireuHttpMultiPartFormDataPartPrivate * priv;
};

struct _edwinspireuHttpMultiPartFormDataPartClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpMultiPartFormData {
	GObject parent_instance;
	edwinspireuHttpMultiPartFormDataPrivate * priv;
};

struct _edwinspireuHttpMultiPartFormDataClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpResponse {
	GObject parent_instance;
	edwinspireuHttpResponsePrivate * priv;
	guint8* Data;
	gint Data_length1;
	edwinspireuHttpStatusCode Status;
	GeeHashMap* Header;
};

struct _edwinspireuHttpResponseClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpuHttpServerConfig {
	GObject parent_instance;
	edwinspireuHttpuHttpServerConfigPrivate * priv;
	guint16 Port;
	gchar* Index;
	gboolean RequestPrintOnConsole;
	gchar* Root;
};

struct _edwinspireuHttpuHttpServerConfigClass {
	GObjectClass parent_class;
};

struct _edwinspireuHttpuHttpServer {
	GObject parent_instance;
	edwinspireuHttpuHttpServerPrivate * priv;
	gint heartbeatseconds;
	edwinspireuHttpuHttpServerConfig* Config;
};

struct _edwinspireuHttpuHttpServerClass {
	GObjectClass parent_class;
	void (*run) (edwinspireuHttpuHttpServer* self);
	gboolean (*connection_handler_virtual) (edwinspireuHttpuHttpServer* self, edwinspireuHttpRequest* request, GDataOutputStream* dos);
};


GType edwinspire_uhttp_http_version_get_type (void) G_GNUC_CONST;
GType edwinspire_uhttp_status_code_get_type (void) G_GNUC_CONST;
GType edwinspire_uhttp_request_method_get_type (void) G_GNUC_CONST;
GType edwinspire_uhttp_form_get_type (void) G_GNUC_CONST;
edwinspireuHttpForm* edwinspire_uhttp_form_new (void);
edwinspireuHttpForm* edwinspire_uhttp_form_construct (GType object_type);
GeeHashMap* edwinspire_uhttp_form_DataDecode (const gchar* data);
GType edwinspire_uhttp_request_get_type (void) G_GNUC_CONST;
edwinspireuHttpRequest* edwinspire_uhttp_request_new (void);
edwinspireuHttpRequest* edwinspire_uhttp_request_construct (GType object_type);
void edwinspire_uhttp_request_from_lines (edwinspireuHttpRequest* self, const gchar* lines);
void edwinspire_uhttp_request_print (edwinspireuHttpRequest* self);
edwinspireuHttpRequestMethod edwinspire_uhttp_request_get_Method (edwinspireuHttpRequest* self);
const gchar* edwinspire_uhttp_request_get_Path (edwinspireuHttpRequest* self);
GeeHashMap* edwinspire_uhttp_request_get_Query (edwinspireuHttpRequest* self);
GeeHashMap* edwinspire_uhttp_request_get_Header (edwinspireuHttpRequest* self);
GeeHashMap* edwinspire_uhttp_request_get_Form (edwinspireuHttpRequest* self);
gboolean edwinspire_uhttp_request_get_isWebSocketHandshake (edwinspireuHttpRequest* self);
GType edwinspire_uhttp_multi_part_form_data_get_type (void) G_GNUC_CONST;
edwinspireuHttpMultiPartFormData* edwinspire_uhttp_request_get_MultiPartForm (edwinspireuHttpRequest* self);
gint edwinspire_uhttp_request_get_ContentLength (edwinspireuHttpRequest* self);
guint8* edwinspire_uhttp_request_get_Data (edwinspireuHttpRequest* self, int* result_length1);
void edwinspire_uhttp_request_set_Data (edwinspireuHttpRequest* self, guint8* value, int value_length1);
GType edwinspire_uhttp_multi_part_form_data_header_get_type (void) G_GNUC_CONST;
edwinspireuHttpMultiPartFormDataHeader* edwinspire_uhttp_multi_part_form_data_header_new (void);
edwinspireuHttpMultiPartFormDataHeader* edwinspire_uhttp_multi_part_form_data_header_construct (GType object_type);
gchar* edwinspire_uhttp_multi_part_form_data_header_get_param_for_name (edwinspireuHttpMultiPartFormDataHeader* self, const gchar* name);
const gchar* edwinspire_uhttp_multi_part_form_data_header_get_name (edwinspireuHttpMultiPartFormDataHeader* self);
void edwinspire_uhttp_multi_part_form_data_header_set_name (edwinspireuHttpMultiPartFormDataHeader* self, const gchar* value);
const gchar* edwinspire_uhttp_multi_part_form_data_header_get_value (edwinspireuHttpMultiPartFormDataHeader* self);
void edwinspire_uhttp_multi_part_form_data_header_set_value (edwinspireuHttpMultiPartFormDataHeader* self, const gchar* value);
GeeHashMap* edwinspire_uhttp_multi_part_form_data_header_get_param (edwinspireuHttpMultiPartFormDataHeader* self);
void edwinspire_uhttp_multi_part_form_data_header_set_param (edwinspireuHttpMultiPartFormDataHeader* self, GeeHashMap* value);
GType edwinspire_uhttp_multi_part_form_data_part_get_type (void) G_GNUC_CONST;
edwinspireuHttpMultiPartFormDataPart* edwinspire_uhttp_multi_part_form_data_part_new (void);
edwinspireuHttpMultiPartFormDataPart* edwinspire_uhttp_multi_part_form_data_part_construct (GType object_type);
gchar* edwinspire_uhttp_multi_part_form_data_part_get_head_param (edwinspireuHttpMultiPartFormDataPart* self, const gchar* head, const gchar* name);
edwinspireuHttpMultiPartFormDataHeader* edwinspire_uhttp_multi_part_form_data_part_get_header_content_disposition (edwinspireuHttpMultiPartFormDataPart* self);
gchar* edwinspire_uhttp_multi_part_form_data_part_get_content_disposition_param (edwinspireuHttpMultiPartFormDataPart* self, const gchar* name);
edwinspireuHttpMultiPartFormDataHeader* edwinspire_uhttp_multi_part_form_data_part_get_header_for_name (edwinspireuHttpMultiPartFormDataPart* self, const gchar* name);
gchar* edwinspire_uhttp_multi_part_form_data_part_get_data_as_string_valid_unichars (edwinspireuHttpMultiPartFormDataPart* self);
gchar* edwinspire_uhttp_multi_part_form_data_part_compute_md5_for_data (edwinspireuHttpMultiPartFormDataPart* self);
GeeArrayList* edwinspire_uhttp_multi_part_form_data_part_get_Headers (edwinspireuHttpMultiPartFormDataPart* self);
void edwinspire_uhttp_multi_part_form_data_part_set_Headers (edwinspireuHttpMultiPartFormDataPart* self, GeeArrayList* value);
guint8* edwinspire_uhttp_multi_part_form_data_part_get_data (edwinspireuHttpMultiPartFormDataPart* self, int* result_length1);
void edwinspire_uhttp_multi_part_form_data_part_set_data (edwinspireuHttpMultiPartFormDataPart* self, guint8* value, int value_length1);
edwinspireuHttpMultiPartFormData* edwinspire_uhttp_multi_part_form_data_new (void);
edwinspireuHttpMultiPartFormData* edwinspire_uhttp_multi_part_form_data_construct (GType object_type);
void edwinspire_uhttp_multi_part_form_data_decode (edwinspireuHttpMultiPartFormData* self, const gchar* ContentTypeHeader, guint8* d, int d_length1);
GeeArrayList* edwinspire_uhttp_multi_part_form_data_get_Parts (edwinspireuHttpMultiPartFormData* self);
const gchar* edwinspire_uhttp_multi_part_form_data_get_boundary (edwinspireuHttpMultiPartFormData* self);
gboolean edwinspire_uhttp_multi_part_form_data_get_is_multipart_form_data (edwinspireuHttpMultiPartFormData* self);
GType edwinspire_uhttp_response_get_type (void) G_GNUC_CONST;
edwinspireuHttpResponse* edwinspire_uhttp_response_new (void);
edwinspireuHttpResponse* edwinspire_uhttp_response_construct (GType object_type);
gchar* edwinspire_uhttp_response_ToString (edwinspireuHttpResponse* self);
gchar* edwinspire_uhttp_response_HtmErrorPage (const gchar* title, const gchar* _error_);
GType edwinspire_uhttp_uhttp_server_config_get_type (void) G_GNUC_CONST;
edwinspireuHttpuHttpServerConfig* edwinspire_uhttp_uhttp_server_config_new (void);
edwinspireuHttpuHttpServerConfig* edwinspire_uhttp_uhttp_server_config_construct (GType object_type);
gchar* edwinspire_uhttp_uhttp_server_config_HashMapToString (GeeHashMap* hm);
void edwinspire_uhttp_uhttp_server_config_read (edwinspireuHttpuHttpServerConfig* self);
gchar* edwinspire_uhttp_uhttp_server_config_ToXml (edwinspireuHttpuHttpServerConfig* self, gboolean fieldtextasbase64);
gboolean edwinspire_uhttp_uhttp_server_config_write (edwinspireuHttpuHttpServerConfig* self);
GType edwinspire_uhttp_uhttp_server_get_type (void) G_GNUC_CONST;
edwinspireuHttpuHttpServer* edwinspire_uhttp_uhttp_server_new (gint max_threads);
edwinspireuHttpuHttpServer* edwinspire_uhttp_uhttp_server_construct (GType object_type, gint max_threads);
gchar* edwinspire_uhttp_uhttp_server_EnumToXml (GType typeenum, gboolean fieldtextasbase64);
void edwinspire_uhttp_uhttp_server_run (edwinspireuHttpuHttpServer* self);
void edwinspire_uhttp_uhttp_server_run_without_mainloop (edwinspireuHttpuHttpServer* self);
gboolean edwinspire_uhttp_uhttp_server_upload_file (edwinspireuHttpuHttpServer* self, const gchar* subpath_file, guint8* data, int data_length1, gboolean replace);
gboolean edwinspire_uhttp_uhttp_server_save_file (const gchar* path, guint8* data, int data_length1, gboolean replace);
gchar* edwinspire_uhttp_uhttp_server_get_data_as_string_valid_unichars (guint8* d, int d_length1);
gchar* edwinspire_uhttp_uhttp_server_GenUrl (const gchar* root, const gchar* value);
gboolean edwinspire_uhttp_uhttp_server_connection_handler_virtual (edwinspireuHttpuHttpServer* self, edwinspireuHttpRequest* request, GDataOutputStream* dos);
void edwinspire_uhttp_uhttp_server_serve_response (edwinspireuHttpuHttpServer* self, edwinspireuHttpResponse* response, GDataOutputStream* dos);
glong edwinspire_uhttp_uhttp_server_writeData (edwinspireuHttpuHttpServer* self, guint8* data_, int data__length1, GDataOutputStream* dos);
void edwinspire_uhttp_uhttp_server_sendEventHeader (edwinspireuHttpuHttpServer* self, GDataOutputStream* dos);
glong edwinspire_uhttp_uhttp_server_sendEvent (edwinspireuHttpuHttpServer* self, const gchar* data, GDataOutputStream* dos);
gchar* edwinspire_uhttp_uhttp_server_PathLocalFile (edwinspireuHttpuHttpServer* self, const gchar* Filex);
gchar* edwinspire_uhttp_uhttp_server_ReadFile (const gchar* path);
guint8* edwinspire_uhttp_uhttp_server_LoadServerFile (edwinspireuHttpuHttpServer* self, const gchar* path, int* result_length1);
gchar* edwinspire_uhttp_uhttp_server_ReadServerFile (edwinspireuHttpuHttpServer* self, const gchar* path);
guint8* edwinspire_uhttp_uhttp_server_LoadFile (const gchar* Path, int* result_length1);
gchar* edwinspire_uhttp_uhttp_server_get_extension_file (const gchar* file_name);


G_END_DECLS

#endif
