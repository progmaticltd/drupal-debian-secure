--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 9.6.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: concat(anynonarray, anynonarray); Type: FUNCTION; Schema: public; Owner: drupal
--

CREATE FUNCTION public.concat(anynonarray, anynonarray) RETURNS text
    LANGUAGE sql
    AS $_$SELECT CAST($1 AS text) || CAST($2 AS text);$_$;


ALTER FUNCTION public.concat(anynonarray, anynonarray) OWNER TO drupal;

--
-- Name: concat(anynonarray, text); Type: FUNCTION; Schema: public; Owner: drupal
--

CREATE FUNCTION public.concat(anynonarray, text) RETURNS text
    LANGUAGE sql
    AS $_$SELECT CAST($1 AS text) || $2;$_$;


ALTER FUNCTION public.concat(anynonarray, text) OWNER TO drupal;

--
-- Name: concat(text, anynonarray); Type: FUNCTION; Schema: public; Owner: drupal
--

CREATE FUNCTION public.concat(text, anynonarray) RETURNS text
    LANGUAGE sql
    AS $_$SELECT $1 || CAST($2 AS text);$_$;


ALTER FUNCTION public.concat(text, anynonarray) OWNER TO drupal;

--
-- Name: concat(text, text); Type: FUNCTION; Schema: public; Owner: drupal
--

CREATE FUNCTION public.concat(text, text) RETURNS text
    LANGUAGE sql
    AS $_$SELECT $1 || $2;$_$;


ALTER FUNCTION public.concat(text, text) OWNER TO drupal;

--
-- Name: greatest(numeric, numeric); Type: FUNCTION; Schema: public; Owner: drupal
--

CREATE FUNCTION public."greatest"(numeric, numeric) RETURNS numeric
    LANGUAGE sql
    AS $_$SELECT CASE WHEN (($1 > $2) OR ($2 IS NULL)) THEN $1 ELSE $2 END;$_$;


ALTER FUNCTION public."greatest"(numeric, numeric) OWNER TO drupal;

--
-- Name: greatest(numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: drupal
--

CREATE FUNCTION public."greatest"(numeric, numeric, numeric) RETURNS numeric
    LANGUAGE sql
    AS $_$SELECT greatest($1, greatest($2, $3));$_$;


ALTER FUNCTION public."greatest"(numeric, numeric, numeric) OWNER TO drupal;

--
-- Name: rand(); Type: FUNCTION; Schema: public; Owner: drupal
--

CREATE FUNCTION public.rand() RETURNS double precision
    LANGUAGE sql
    AS $$SELECT random();$$;


ALTER FUNCTION public.rand() OWNER TO drupal;

--
-- Name: substring_index(text, text, integer); Type: FUNCTION; Schema: public; Owner: drupal
--

CREATE FUNCTION public.substring_index(text, text, integer) RETURNS text
    LANGUAGE sql
    AS $_$SELECT array_to_string((string_to_array($1, $2)) [1:$3], $2);$_$;


ALTER FUNCTION public.substring_index(text, text, integer) OWNER TO drupal;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actions; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.actions (
    aid character varying(255) DEFAULT '0'::character varying NOT NULL,
    type character varying(32) DEFAULT ''::character varying NOT NULL,
    callback character varying(255) DEFAULT ''::character varying NOT NULL,
    parameters bytea NOT NULL,
    label character varying(255) DEFAULT '0'::character varying NOT NULL
);


ALTER TABLE public.actions OWNER TO drupal;

--
-- Name: TABLE actions; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.actions IS 'Stores action information.';


--
-- Name: COLUMN actions.aid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.actions.aid IS 'Primary Key: Unique actions ID.';


--
-- Name: COLUMN actions.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.actions.type IS 'The object that that action acts on (node, user, comment, system or custom types.)';


--
-- Name: COLUMN actions.callback; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.actions.callback IS 'The callback function that executes when the action runs.';


--
-- Name: COLUMN actions.parameters; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.actions.parameters IS 'Parameters to be passed to the callback function.';


--
-- Name: COLUMN actions.label; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.actions.label IS 'Label of the action.';


--
-- Name: authmap; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.authmap (
    aid integer NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    authname character varying(128) DEFAULT ''::character varying NOT NULL,
    module character varying(128) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT authmap_aid_check CHECK ((aid >= 0))
);


ALTER TABLE public.authmap OWNER TO drupal;

--
-- Name: TABLE authmap; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.authmap IS 'Stores distributed authentication mapping.';


--
-- Name: COLUMN authmap.aid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.authmap.aid IS 'Primary Key: Unique authmap ID.';


--
-- Name: COLUMN authmap.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.authmap.uid IS 'User''s users.uid.';


--
-- Name: COLUMN authmap.authname; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.authmap.authname IS 'Unique authentication name.';


--
-- Name: COLUMN authmap.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.authmap.module IS 'Module which is controlling the authentication.';


--
-- Name: authmap_aid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.authmap_aid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authmap_aid_seq OWNER TO drupal;

--
-- Name: authmap_aid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.authmap_aid_seq OWNED BY public.authmap.aid;


--
-- Name: batch; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.batch (
    bid bigint NOT NULL,
    token character varying(64) NOT NULL,
    "timestamp" integer NOT NULL,
    batch bytea,
    CONSTRAINT batch_bid_check CHECK ((bid >= 0))
);


ALTER TABLE public.batch OWNER TO drupal;

--
-- Name: TABLE batch; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.batch IS 'Stores details about batches (processes that run in multiple HTTP requests).';


--
-- Name: COLUMN batch.bid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.batch.bid IS 'Primary Key: Unique batch ID.';


--
-- Name: COLUMN batch.token; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.batch.token IS 'A string token generated against the current user''s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.';


--
-- Name: COLUMN batch."timestamp"; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.batch."timestamp" IS 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.';


--
-- Name: COLUMN batch.batch; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.batch.batch IS 'A serialized array containing the processing data for the batch.';


--
-- Name: block; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.block (
    bid integer NOT NULL,
    module character varying(64) DEFAULT ''::character varying NOT NULL,
    delta character varying(32) DEFAULT '0'::character varying NOT NULL,
    theme character varying(64) DEFAULT ''::character varying NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    region character varying(64) DEFAULT ''::character varying NOT NULL,
    custom smallint DEFAULT 0 NOT NULL,
    visibility smallint DEFAULT 0 NOT NULL,
    pages text NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    cache smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.block OWNER TO drupal;

--
-- Name: TABLE block; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.block IS 'Stores block settings, such as region and visibility settings.';


--
-- Name: COLUMN block.bid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.bid IS 'Primary Key: Unique block ID.';


--
-- Name: COLUMN block.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.module IS 'The module from which the block originates; for example, ''user'' for the Who''s Online block, and ''block'' for any custom blocks.';


--
-- Name: COLUMN block.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.delta IS 'Unique ID for block within a module.';


--
-- Name: COLUMN block.theme; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.theme IS 'The theme under which the block settings apply.';


--
-- Name: COLUMN block.status; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.status IS 'Block enabled status. (1 = enabled, 0 = disabled)';


--
-- Name: COLUMN block.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.weight IS 'Block weight within region.';


--
-- Name: COLUMN block.region; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.region IS 'Theme region within which the block is set.';


--
-- Name: COLUMN block.custom; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.custom IS 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)';


--
-- Name: COLUMN block.visibility; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.visibility IS 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)';


--
-- Name: COLUMN block.pages; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.pages IS 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.';


--
-- Name: COLUMN block.title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.title IS 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)';


--
-- Name: COLUMN block.cache; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block.cache IS 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.';


--
-- Name: block_bid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.block_bid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.block_bid_seq OWNER TO drupal;

--
-- Name: block_bid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.block_bid_seq OWNED BY public.block.bid;


--
-- Name: block_custom; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.block_custom (
    bid integer NOT NULL,
    body text,
    info character varying(128) DEFAULT ''::character varying NOT NULL,
    format character varying(255),
    CONSTRAINT block_custom_bid_check CHECK ((bid >= 0))
);


ALTER TABLE public.block_custom OWNER TO drupal;

--
-- Name: TABLE block_custom; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.block_custom IS 'Stores contents of custom-made blocks.';


--
-- Name: COLUMN block_custom.bid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_custom.bid IS 'The block''s block.bid.';


--
-- Name: COLUMN block_custom.body; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_custom.body IS 'Block contents.';


--
-- Name: COLUMN block_custom.info; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_custom.info IS 'Block description.';


--
-- Name: COLUMN block_custom.format; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_custom.format IS 'The filter_format.format of the block body.';


--
-- Name: block_custom_bid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.block_custom_bid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.block_custom_bid_seq OWNER TO drupal;

--
-- Name: block_custom_bid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.block_custom_bid_seq OWNED BY public.block_custom.bid;


--
-- Name: block_node_type; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.block_node_type (
    module character varying(64) NOT NULL,
    delta character varying(32) NOT NULL,
    type character varying(32) NOT NULL
);


ALTER TABLE public.block_node_type OWNER TO drupal;

--
-- Name: TABLE block_node_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.block_node_type IS 'Sets up display criteria for blocks based on content types';


--
-- Name: COLUMN block_node_type.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_node_type.module IS 'The block''s origin module, from block.module.';


--
-- Name: COLUMN block_node_type.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_node_type.delta IS 'The block''s unique delta within module, from block.delta.';


--
-- Name: COLUMN block_node_type.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_node_type.type IS 'The machine-readable name of this type from node_type.type.';


--
-- Name: block_role; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.block_role (
    module character varying(64) NOT NULL,
    delta character varying(32) NOT NULL,
    rid bigint NOT NULL,
    CONSTRAINT block_role_rid_check CHECK ((rid >= 0))
);


ALTER TABLE public.block_role OWNER TO drupal;

--
-- Name: TABLE block_role; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.block_role IS 'Sets up access permissions for blocks based on user roles';


--
-- Name: COLUMN block_role.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_role.module IS 'The block''s origin module, from block.module.';


--
-- Name: COLUMN block_role.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_role.delta IS 'The block''s unique delta within module, from block.delta.';


--
-- Name: COLUMN block_role.rid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.block_role.rid IS 'The user''s role ID from users_roles.rid.';


--
-- Name: blocked_ips; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.blocked_ips (
    iid integer NOT NULL,
    ip character varying(40) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT blocked_ips_iid_check CHECK ((iid >= 0))
);


ALTER TABLE public.blocked_ips OWNER TO drupal;

--
-- Name: TABLE blocked_ips; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.blocked_ips IS 'Stores blocked IP addresses.';


--
-- Name: COLUMN blocked_ips.iid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.blocked_ips.iid IS 'Primary Key: unique ID for IP addresses.';


--
-- Name: COLUMN blocked_ips.ip; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.blocked_ips.ip IS 'IP address';


--
-- Name: blocked_ips_iid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.blocked_ips_iid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blocked_ips_iid_seq OWNER TO drupal;

--
-- Name: blocked_ips_iid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.blocked_ips_iid_seq OWNED BY public.blocked_ips.iid;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache OWNER TO drupal;

--
-- Name: TABLE cache; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache IS 'Generic cache table for caching things not separated out into their own tables. Contributed modules may also use this to store cached items.';


--
-- Name: COLUMN cache.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_block; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_block (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_block OWNER TO drupal;

--
-- Name: TABLE cache_block; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_block IS 'Cache table for the Block module to store already built blocks, identified by module, delta, and various contexts which may change the block, such as theme, locale, and caching mode defined for the block.';


--
-- Name: COLUMN cache_block.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_block.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_block.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_block.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_block.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_block.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_block.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_block.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_block.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_block.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_bootstrap; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_bootstrap (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_bootstrap OWNER TO drupal;

--
-- Name: TABLE cache_bootstrap; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_bootstrap IS 'Cache table for data required to bootstrap Drupal, may be routed to a shared memory cache.';


--
-- Name: COLUMN cache_bootstrap.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_bootstrap.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_bootstrap.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_bootstrap.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_bootstrap.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_bootstrap.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_bootstrap.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_bootstrap.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_bootstrap.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_bootstrap.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_field; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_field (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_field OWNER TO drupal;

--
-- Name: TABLE cache_field; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_field IS 'Cache table for the Field module to store already built field information.';


--
-- Name: COLUMN cache_field.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_field.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_field.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_field.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_field.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_field.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_field.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_field.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_field.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_field.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_filter; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_filter (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_filter OWNER TO drupal;

--
-- Name: TABLE cache_filter; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_filter IS 'Cache table for the Filter module to store already filtered pieces of text, identified by text format and hash of the text.';


--
-- Name: COLUMN cache_filter.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_filter.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_filter.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_filter.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_filter.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_filter.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_filter.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_filter.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_filter.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_filter.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_form; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_form (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_form OWNER TO drupal;

--
-- Name: TABLE cache_form; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_form IS 'Cache table for the form system to store recently built forms and their storage data, to be used in subsequent page requests.';


--
-- Name: COLUMN cache_form.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_form.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_form.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_form.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_form.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_form.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_form.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_form.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_form.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_form.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_image; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_image (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_image OWNER TO drupal;

--
-- Name: TABLE cache_image; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_image IS 'Cache table used to store information about image manipulations that are in-progress.';


--
-- Name: COLUMN cache_image.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_image.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_image.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_image.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_image.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_image.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_image.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_image.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_image.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_image.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_menu; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_menu (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_menu OWNER TO drupal;

--
-- Name: TABLE cache_menu; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_menu IS 'Cache table for the menu system to store router information as well as generated link trees for various menu/page/user combinations.';


--
-- Name: COLUMN cache_menu.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_menu.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_menu.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_menu.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_menu.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_menu.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_menu.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_menu.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_menu.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_menu.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_page; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_page (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_page OWNER TO drupal;

--
-- Name: TABLE cache_page; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_page IS 'Cache table used to store compressed pages for anonymous users, if page caching is enabled.';


--
-- Name: COLUMN cache_page.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_page.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_page.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_page.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_page.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_page.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_page.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_page.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_page.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_page.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_path; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_path (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_path OWNER TO drupal;

--
-- Name: TABLE cache_path; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_path IS 'Cache table for path alias lookup.';


--
-- Name: COLUMN cache_path.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_path.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_path.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_path.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_path.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_path.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_path.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_path.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_path.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_path.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: cache_update; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.cache_update (
    cid character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    serialized smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.cache_update OWNER TO drupal;

--
-- Name: TABLE cache_update; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.cache_update IS 'Cache table for the Update module to store information about available releases, fetched from central server.';


--
-- Name: COLUMN cache_update.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_update.cid IS 'Primary Key: Unique cache ID.';


--
-- Name: COLUMN cache_update.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_update.data IS 'A collection of data to cache.';


--
-- Name: COLUMN cache_update.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_update.expire IS 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.';


--
-- Name: COLUMN cache_update.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_update.created IS 'A Unix timestamp indicating when the cache entry was created.';


--
-- Name: COLUMN cache_update.serialized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.cache_update.serialized IS 'A flag to indicate whether content is serialized (1) or not (0).';


--
-- Name: comment; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.comment (
    cid integer NOT NULL,
    pid integer DEFAULT 0 NOT NULL,
    nid integer DEFAULT 0 NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    subject character varying(64) DEFAULT ''::character varying NOT NULL,
    hostname character varying(128) DEFAULT ''::character varying NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    changed integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    thread character varying(255) NOT NULL,
    name character varying(60),
    mail character varying(64),
    homepage character varying(255),
    language character varying(12) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT comment_status_check CHECK ((status >= 0))
);


ALTER TABLE public.comment OWNER TO drupal;

--
-- Name: TABLE comment; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.comment IS 'Stores comments and associated data.';


--
-- Name: COLUMN comment.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.cid IS 'Primary Key: Unique comment ID.';


--
-- Name: COLUMN comment.pid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.pid IS 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.';


--
-- Name: COLUMN comment.nid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.nid IS 'The node.nid to which this comment is a reply.';


--
-- Name: COLUMN comment.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.uid IS 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.';


--
-- Name: COLUMN comment.subject; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.subject IS 'The comment title.';


--
-- Name: COLUMN comment.hostname; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.hostname IS 'The author''s host name.';


--
-- Name: COLUMN comment.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.created IS 'The time that the comment was created, as a Unix timestamp.';


--
-- Name: COLUMN comment.changed; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.changed IS 'The time that the comment was last edited, as a Unix timestamp.';


--
-- Name: COLUMN comment.status; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.status IS 'The published status of a comment. (0 = Not Published, 1 = Published)';


--
-- Name: COLUMN comment.thread; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.thread IS 'The vancode representation of the comment''s place in a thread.';


--
-- Name: COLUMN comment.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.name IS 'The comment author''s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.';


--
-- Name: COLUMN comment.mail; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.mail IS 'The comment author''s e-mail address from the comment form, if user is anonymous, and the ''Anonymous users may/must leave their contact information'' setting is turned on.';


--
-- Name: COLUMN comment.homepage; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.homepage IS 'The comment author''s home page address from the comment form, if user is anonymous, and the ''Anonymous users may/must leave their contact information'' setting is turned on.';


--
-- Name: COLUMN comment.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.comment.language IS 'The languages.language of this comment.';


--
-- Name: comment_cid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.comment_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_cid_seq OWNER TO drupal;

--
-- Name: comment_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.comment_cid_seq OWNED BY public.comment.cid;


--
-- Name: date_format_locale; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.date_format_locale (
    format character varying(100) NOT NULL,
    type character varying(64) NOT NULL,
    language character varying(12) NOT NULL
);


ALTER TABLE public.date_format_locale OWNER TO drupal;

--
-- Name: TABLE date_format_locale; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.date_format_locale IS 'Stores configured date formats for each locale.';


--
-- Name: COLUMN date_format_locale.format; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_format_locale.format IS 'The date format string.';


--
-- Name: COLUMN date_format_locale.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_format_locale.type IS 'The date format type, e.g. medium.';


--
-- Name: COLUMN date_format_locale.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_format_locale.language IS 'A languages.language for this format to be used with.';


--
-- Name: date_format_type; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.date_format_type (
    type character varying(64) NOT NULL,
    title character varying(255) NOT NULL,
    locked smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.date_format_type OWNER TO drupal;

--
-- Name: TABLE date_format_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.date_format_type IS 'Stores configured date format types.';


--
-- Name: COLUMN date_format_type.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_format_type.type IS 'The date format type, e.g. medium.';


--
-- Name: COLUMN date_format_type.title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_format_type.title IS 'The human readable name of the format type.';


--
-- Name: COLUMN date_format_type.locked; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_format_type.locked IS 'Whether or not this is a system provided format.';


--
-- Name: date_formats; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.date_formats (
    dfid integer NOT NULL,
    format character varying(100) NOT NULL,
    type character varying(64) NOT NULL,
    locked smallint DEFAULT 0 NOT NULL,
    CONSTRAINT date_formats_dfid_check CHECK ((dfid >= 0))
);


ALTER TABLE public.date_formats OWNER TO drupal;

--
-- Name: TABLE date_formats; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.date_formats IS 'Stores configured date formats.';


--
-- Name: COLUMN date_formats.dfid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_formats.dfid IS 'The date format identifier.';


--
-- Name: COLUMN date_formats.format; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_formats.format IS 'The date format string.';


--
-- Name: COLUMN date_formats.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_formats.type IS 'The date format type, e.g. medium.';


--
-- Name: COLUMN date_formats.locked; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.date_formats.locked IS 'Whether or not this format can be modified.';


--
-- Name: date_formats_dfid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.date_formats_dfid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.date_formats_dfid_seq OWNER TO drupal;

--
-- Name: date_formats_dfid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.date_formats_dfid_seq OWNED BY public.date_formats.dfid;


--
-- Name: field_config; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_config (
    id integer NOT NULL,
    field_name character varying(32) NOT NULL,
    type character varying(128) NOT NULL,
    module character varying(128) DEFAULT ''::character varying NOT NULL,
    active smallint DEFAULT 0 NOT NULL,
    storage_type character varying(128) NOT NULL,
    storage_module character varying(128) DEFAULT ''::character varying NOT NULL,
    storage_active smallint DEFAULT 0 NOT NULL,
    locked smallint DEFAULT 0 NOT NULL,
    data bytea NOT NULL,
    cardinality smallint DEFAULT 0 NOT NULL,
    translatable smallint DEFAULT 0 NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.field_config OWNER TO drupal;

--
-- Name: COLUMN field_config.id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.id IS 'The primary identifier for a field';


--
-- Name: COLUMN field_config.field_name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.field_name IS 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.';


--
-- Name: COLUMN field_config.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.type IS 'The type of this field.';


--
-- Name: COLUMN field_config.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.module IS 'The module that implements the field type.';


--
-- Name: COLUMN field_config.active; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.active IS 'Boolean indicating whether the module that implements the field type is enabled.';


--
-- Name: COLUMN field_config.storage_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.storage_type IS 'The storage backend for the field.';


--
-- Name: COLUMN field_config.storage_module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.storage_module IS 'The module that implements the storage backend.';


--
-- Name: COLUMN field_config.storage_active; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.storage_active IS 'Boolean indicating whether the module that implements the storage backend is enabled.';


--
-- Name: COLUMN field_config.locked; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.locked IS '@TODO';


--
-- Name: COLUMN field_config.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config.data IS 'Serialized data containing the field properties that do not warrant a dedicated column.';


--
-- Name: field_config_id_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.field_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_config_id_seq OWNER TO drupal;

--
-- Name: field_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.field_config_id_seq OWNED BY public.field_config.id;


--
-- Name: field_config_instance; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_config_instance (
    id integer NOT NULL,
    field_id integer NOT NULL,
    field_name character varying(32) DEFAULT ''::character varying NOT NULL,
    entity_type character varying(32) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    data bytea NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.field_config_instance OWNER TO drupal;

--
-- Name: COLUMN field_config_instance.id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config_instance.id IS 'The primary identifier for a field instance';


--
-- Name: COLUMN field_config_instance.field_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_config_instance.field_id IS 'The identifier of the field attached by this instance';


--
-- Name: field_config_instance_id_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.field_config_instance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.field_config_instance_id_seq OWNER TO drupal;

--
-- Name: field_config_instance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.field_config_instance_id_seq OWNED BY public.field_config_instance.id;


--
-- Name: field_data_body; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_data_body (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    body_value text,
    body_summary text,
    body_format character varying(255),
    CONSTRAINT field_data_body_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_body_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_body_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_body OWNER TO drupal;

--
-- Name: TABLE field_data_body; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.field_data_body IS 'Data storage for field 2 (body)';


--
-- Name: COLUMN field_data_body.entity_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_body.entity_type IS 'The entity type this data is attached to';


--
-- Name: COLUMN field_data_body.bundle; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_body.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- Name: COLUMN field_data_body.deleted; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_body.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- Name: COLUMN field_data_body.entity_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_body.entity_id IS 'The entity id this data is attached to';


--
-- Name: COLUMN field_data_body.revision_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_body.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- Name: COLUMN field_data_body.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_body.language IS 'The language for this data item.';


--
-- Name: COLUMN field_data_body.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_body.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- Name: field_data_comment_body; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_data_comment_body (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    comment_body_value text,
    comment_body_format character varying(255),
    CONSTRAINT field_data_comment_body_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_comment_body_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_comment_body_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_comment_body OWNER TO drupal;

--
-- Name: TABLE field_data_comment_body; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.field_data_comment_body IS 'Data storage for field 1 (comment_body)';


--
-- Name: COLUMN field_data_comment_body.entity_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_comment_body.entity_type IS 'The entity type this data is attached to';


--
-- Name: COLUMN field_data_comment_body.bundle; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_comment_body.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- Name: COLUMN field_data_comment_body.deleted; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_comment_body.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- Name: COLUMN field_data_comment_body.entity_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_comment_body.entity_id IS 'The entity id this data is attached to';


--
-- Name: COLUMN field_data_comment_body.revision_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_comment_body.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- Name: COLUMN field_data_comment_body.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_comment_body.language IS 'The language for this data item.';


--
-- Name: COLUMN field_data_comment_body.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_comment_body.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- Name: field_data_field_image; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_data_field_image (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_image_fid bigint,
    field_image_alt character varying(512),
    field_image_title character varying(1024),
    field_image_width bigint,
    field_image_height bigint,
    CONSTRAINT field_data_field_image_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_field_image_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_field_image_field_image_fid_check CHECK ((field_image_fid >= 0)),
    CONSTRAINT field_data_field_image_field_image_height_check CHECK ((field_image_height >= 0)),
    CONSTRAINT field_data_field_image_field_image_width_check CHECK ((field_image_width >= 0)),
    CONSTRAINT field_data_field_image_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_field_image OWNER TO drupal;

--
-- Name: TABLE field_data_field_image; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.field_data_field_image IS 'Data storage for field 4 (field_image)';


--
-- Name: COLUMN field_data_field_image.entity_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.entity_type IS 'The entity type this data is attached to';


--
-- Name: COLUMN field_data_field_image.bundle; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- Name: COLUMN field_data_field_image.deleted; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- Name: COLUMN field_data_field_image.entity_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.entity_id IS 'The entity id this data is attached to';


--
-- Name: COLUMN field_data_field_image.revision_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- Name: COLUMN field_data_field_image.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.language IS 'The language for this data item.';


--
-- Name: COLUMN field_data_field_image.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- Name: COLUMN field_data_field_image.field_image_fid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.field_image_fid IS 'The file_managed.fid being referenced in this field.';


--
-- Name: COLUMN field_data_field_image.field_image_alt; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.field_image_alt IS 'Alternative image text, for the image''s ''alt'' attribute.';


--
-- Name: COLUMN field_data_field_image.field_image_title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.field_image_title IS 'Image title text, for the image''s ''title'' attribute.';


--
-- Name: COLUMN field_data_field_image.field_image_width; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.field_image_width IS 'The width of the image in pixels.';


--
-- Name: COLUMN field_data_field_image.field_image_height; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_image.field_image_height IS 'The height of the image in pixels.';


--
-- Name: field_data_field_tags; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_data_field_tags (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_tags_tid bigint,
    CONSTRAINT field_data_field_tags_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_data_field_tags_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_data_field_tags_field_tags_tid_check CHECK ((field_tags_tid >= 0)),
    CONSTRAINT field_data_field_tags_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_data_field_tags OWNER TO drupal;

--
-- Name: TABLE field_data_field_tags; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.field_data_field_tags IS 'Data storage for field 3 (field_tags)';


--
-- Name: COLUMN field_data_field_tags.entity_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_tags.entity_type IS 'The entity type this data is attached to';


--
-- Name: COLUMN field_data_field_tags.bundle; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_tags.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- Name: COLUMN field_data_field_tags.deleted; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_tags.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- Name: COLUMN field_data_field_tags.entity_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_tags.entity_id IS 'The entity id this data is attached to';


--
-- Name: COLUMN field_data_field_tags.revision_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_tags.revision_id IS 'The entity revision id this data is attached to, or NULL if the entity type is not versioned';


--
-- Name: COLUMN field_data_field_tags.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_tags.language IS 'The language for this data item.';


--
-- Name: COLUMN field_data_field_tags.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_data_field_tags.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- Name: field_revision_body; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_revision_body (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    body_value text,
    body_summary text,
    body_format character varying(255),
    CONSTRAINT field_revision_body_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_body_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_body_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_body OWNER TO drupal;

--
-- Name: TABLE field_revision_body; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.field_revision_body IS 'Revision archive storage for field 2 (body)';


--
-- Name: COLUMN field_revision_body.entity_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_body.entity_type IS 'The entity type this data is attached to';


--
-- Name: COLUMN field_revision_body.bundle; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_body.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- Name: COLUMN field_revision_body.deleted; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_body.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- Name: COLUMN field_revision_body.entity_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_body.entity_id IS 'The entity id this data is attached to';


--
-- Name: COLUMN field_revision_body.revision_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_body.revision_id IS 'The entity revision id this data is attached to';


--
-- Name: COLUMN field_revision_body.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_body.language IS 'The language for this data item.';


--
-- Name: COLUMN field_revision_body.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_body.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- Name: field_revision_comment_body; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_revision_comment_body (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    comment_body_value text,
    comment_body_format character varying(255),
    CONSTRAINT field_revision_comment_body_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_comment_body_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_comment_body_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_comment_body OWNER TO drupal;

--
-- Name: TABLE field_revision_comment_body; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.field_revision_comment_body IS 'Revision archive storage for field 1 (comment_body)';


--
-- Name: COLUMN field_revision_comment_body.entity_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_comment_body.entity_type IS 'The entity type this data is attached to';


--
-- Name: COLUMN field_revision_comment_body.bundle; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_comment_body.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- Name: COLUMN field_revision_comment_body.deleted; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_comment_body.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- Name: COLUMN field_revision_comment_body.entity_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_comment_body.entity_id IS 'The entity id this data is attached to';


--
-- Name: COLUMN field_revision_comment_body.revision_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_comment_body.revision_id IS 'The entity revision id this data is attached to';


--
-- Name: COLUMN field_revision_comment_body.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_comment_body.language IS 'The language for this data item.';


--
-- Name: COLUMN field_revision_comment_body.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_comment_body.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- Name: field_revision_field_image; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_revision_field_image (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_image_fid bigint,
    field_image_alt character varying(512),
    field_image_title character varying(1024),
    field_image_width bigint,
    field_image_height bigint,
    CONSTRAINT field_revision_field_image_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_field_image_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_field_image_field_image_fid_check CHECK ((field_image_fid >= 0)),
    CONSTRAINT field_revision_field_image_field_image_height_check CHECK ((field_image_height >= 0)),
    CONSTRAINT field_revision_field_image_field_image_width_check CHECK ((field_image_width >= 0)),
    CONSTRAINT field_revision_field_image_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_field_image OWNER TO drupal;

--
-- Name: TABLE field_revision_field_image; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.field_revision_field_image IS 'Revision archive storage for field 4 (field_image)';


--
-- Name: COLUMN field_revision_field_image.entity_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.entity_type IS 'The entity type this data is attached to';


--
-- Name: COLUMN field_revision_field_image.bundle; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- Name: COLUMN field_revision_field_image.deleted; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- Name: COLUMN field_revision_field_image.entity_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.entity_id IS 'The entity id this data is attached to';


--
-- Name: COLUMN field_revision_field_image.revision_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.revision_id IS 'The entity revision id this data is attached to';


--
-- Name: COLUMN field_revision_field_image.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.language IS 'The language for this data item.';


--
-- Name: COLUMN field_revision_field_image.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- Name: COLUMN field_revision_field_image.field_image_fid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.field_image_fid IS 'The file_managed.fid being referenced in this field.';


--
-- Name: COLUMN field_revision_field_image.field_image_alt; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.field_image_alt IS 'Alternative image text, for the image''s ''alt'' attribute.';


--
-- Name: COLUMN field_revision_field_image.field_image_title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.field_image_title IS 'Image title text, for the image''s ''title'' attribute.';


--
-- Name: COLUMN field_revision_field_image.field_image_width; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.field_image_width IS 'The width of the image in pixels.';


--
-- Name: COLUMN field_revision_field_image.field_image_height; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_image.field_image_height IS 'The height of the image in pixels.';


--
-- Name: field_revision_field_tags; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.field_revision_field_tags (
    entity_type character varying(128) DEFAULT ''::character varying NOT NULL,
    bundle character varying(128) DEFAULT ''::character varying NOT NULL,
    deleted smallint DEFAULT 0 NOT NULL,
    entity_id bigint NOT NULL,
    revision_id bigint NOT NULL,
    language character varying(32) DEFAULT ''::character varying NOT NULL,
    delta bigint NOT NULL,
    field_tags_tid bigint,
    CONSTRAINT field_revision_field_tags_delta_check CHECK ((delta >= 0)),
    CONSTRAINT field_revision_field_tags_entity_id_check CHECK ((entity_id >= 0)),
    CONSTRAINT field_revision_field_tags_field_tags_tid_check CHECK ((field_tags_tid >= 0)),
    CONSTRAINT field_revision_field_tags_revision_id_check CHECK ((revision_id >= 0))
);


ALTER TABLE public.field_revision_field_tags OWNER TO drupal;

--
-- Name: TABLE field_revision_field_tags; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.field_revision_field_tags IS 'Revision archive storage for field 3 (field_tags)';


--
-- Name: COLUMN field_revision_field_tags.entity_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_tags.entity_type IS 'The entity type this data is attached to';


--
-- Name: COLUMN field_revision_field_tags.bundle; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_tags.bundle IS 'The field instance bundle to which this row belongs, used when deleting a field instance';


--
-- Name: COLUMN field_revision_field_tags.deleted; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_tags.deleted IS 'A boolean indicating whether this data item has been deleted';


--
-- Name: COLUMN field_revision_field_tags.entity_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_tags.entity_id IS 'The entity id this data is attached to';


--
-- Name: COLUMN field_revision_field_tags.revision_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_tags.revision_id IS 'The entity revision id this data is attached to';


--
-- Name: COLUMN field_revision_field_tags.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_tags.language IS 'The language for this data item.';


--
-- Name: COLUMN field_revision_field_tags.delta; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.field_revision_field_tags.delta IS 'The sequence number for this data item, used for multi-value fields';


--
-- Name: file_managed; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.file_managed (
    fid integer NOT NULL,
    uid bigint DEFAULT 0 NOT NULL,
    filename character varying(255) DEFAULT ''::character varying NOT NULL,
    uri character varying(255) DEFAULT ''::character varying NOT NULL,
    filemime character varying(255) DEFAULT ''::character varying NOT NULL,
    filesize bigint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    "timestamp" bigint DEFAULT 0 NOT NULL,
    CONSTRAINT file_managed_fid_check CHECK ((fid >= 0)),
    CONSTRAINT file_managed_filesize_check CHECK ((filesize >= 0)),
    CONSTRAINT file_managed_timestamp_check CHECK (("timestamp" >= 0)),
    CONSTRAINT file_managed_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.file_managed OWNER TO drupal;

--
-- Name: TABLE file_managed; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.file_managed IS 'Stores information for uploaded files.';


--
-- Name: COLUMN file_managed.fid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_managed.fid IS 'File ID.';


--
-- Name: COLUMN file_managed.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_managed.uid IS 'The users.uid of the user who is associated with the file.';


--
-- Name: COLUMN file_managed.filename; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_managed.filename IS 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.';


--
-- Name: COLUMN file_managed.uri; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_managed.uri IS 'The URI to access the file (either local or remote).';


--
-- Name: COLUMN file_managed.filemime; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_managed.filemime IS 'The file''s MIME type.';


--
-- Name: COLUMN file_managed.filesize; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_managed.filesize IS 'The size of the file in bytes.';


--
-- Name: COLUMN file_managed.status; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_managed.status IS 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.';


--
-- Name: COLUMN file_managed."timestamp"; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_managed."timestamp" IS 'UNIX timestamp for when the file was added.';


--
-- Name: file_managed_fid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.file_managed_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_managed_fid_seq OWNER TO drupal;

--
-- Name: file_managed_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.file_managed_fid_seq OWNED BY public.file_managed.fid;


--
-- Name: file_usage; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.file_usage (
    fid bigint NOT NULL,
    module character varying(255) DEFAULT ''::character varying NOT NULL,
    type character varying(64) DEFAULT ''::character varying NOT NULL,
    id bigint DEFAULT 0 NOT NULL,
    count bigint DEFAULT 0 NOT NULL,
    CONSTRAINT file_usage_count_check CHECK ((count >= 0)),
    CONSTRAINT file_usage_fid_check CHECK ((fid >= 0)),
    CONSTRAINT file_usage_id_check CHECK ((id >= 0))
);


ALTER TABLE public.file_usage OWNER TO drupal;

--
-- Name: TABLE file_usage; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.file_usage IS 'Track where a file is used.';


--
-- Name: COLUMN file_usage.fid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_usage.fid IS 'File ID.';


--
-- Name: COLUMN file_usage.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_usage.module IS 'The name of the module that is using the file.';


--
-- Name: COLUMN file_usage.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_usage.type IS 'The name of the object type in which the file is used.';


--
-- Name: COLUMN file_usage.id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_usage.id IS 'The primary key of the object using the file.';


--
-- Name: COLUMN file_usage.count; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.file_usage.count IS 'The number of times this file is used by this object.';


--
-- Name: filter; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.filter (
    format character varying(255) NOT NULL,
    module character varying(64) DEFAULT ''::character varying NOT NULL,
    name character varying(32) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    settings bytea
);


ALTER TABLE public.filter OWNER TO drupal;

--
-- Name: TABLE filter; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.filter IS 'Table that maps filters (HTML corrector) to text formats (Filtered HTML).';


--
-- Name: COLUMN filter.format; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter.format IS 'Foreign key: The filter_format.format to which this filter is assigned.';


--
-- Name: COLUMN filter.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter.module IS 'The origin module of the filter.';


--
-- Name: COLUMN filter.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter.name IS 'Name of the filter being referenced.';


--
-- Name: COLUMN filter.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter.weight IS 'Weight of filter within format.';


--
-- Name: COLUMN filter.status; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter.status IS 'Filter enabled status. (1 = enabled, 0 = disabled)';


--
-- Name: COLUMN filter.settings; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter.settings IS 'A serialized array of name value pairs that store the filter settings for the specific format.';


--
-- Name: filter_format; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.filter_format (
    format character varying(255) NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    cache smallint DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    CONSTRAINT filter_format_status_check CHECK ((status >= 0))
);


ALTER TABLE public.filter_format OWNER TO drupal;

--
-- Name: TABLE filter_format; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.filter_format IS 'Stores text formats: custom groupings of filters, such as Filtered HTML.';


--
-- Name: COLUMN filter_format.format; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter_format.format IS 'Primary Key: Unique machine name of the format.';


--
-- Name: COLUMN filter_format.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter_format.name IS 'Name of the text format (Filtered HTML).';


--
-- Name: COLUMN filter_format.cache; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter_format.cache IS 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)';


--
-- Name: COLUMN filter_format.status; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter_format.status IS 'The status of the text format. (1 = enabled, 0 = disabled)';


--
-- Name: COLUMN filter_format.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.filter_format.weight IS 'Weight of text format to use when listing.';


--
-- Name: flood; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.flood (
    fid integer NOT NULL,
    event character varying(64) DEFAULT ''::character varying NOT NULL,
    identifier character varying(128) DEFAULT ''::character varying NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    expiration integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.flood OWNER TO drupal;

--
-- Name: TABLE flood; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.flood IS 'Flood controls the threshold of events, such as the number of contact attempts.';


--
-- Name: COLUMN flood.fid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.flood.fid IS 'Unique flood event ID.';


--
-- Name: COLUMN flood.event; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.flood.event IS 'Name of event (e.g. contact).';


--
-- Name: COLUMN flood.identifier; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.flood.identifier IS 'Identifier of the visitor, such as an IP address or hostname.';


--
-- Name: COLUMN flood."timestamp"; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.flood."timestamp" IS 'Timestamp of the event.';


--
-- Name: COLUMN flood.expiration; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.flood.expiration IS 'Expiration timestamp. Expired events are purged on cron run.';


--
-- Name: flood_fid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.flood_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flood_fid_seq OWNER TO drupal;

--
-- Name: flood_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.flood_fid_seq OWNED BY public.flood.fid;


--
-- Name: history; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.history (
    uid integer DEFAULT 0 NOT NULL,
    nid bigint DEFAULT 0 NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    CONSTRAINT history_nid_check CHECK ((nid >= 0))
);


ALTER TABLE public.history OWNER TO drupal;

--
-- Name: TABLE history; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.history IS 'A record of which users have read which nodes.';


--
-- Name: COLUMN history.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.history.uid IS 'The users.uid that read the node nid.';


--
-- Name: COLUMN history.nid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.history.nid IS 'The node.nid that was read.';


--
-- Name: COLUMN history."timestamp"; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.history."timestamp" IS 'The Unix timestamp at which the read occurred.';


--
-- Name: image_effects; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.image_effects (
    ieid integer NOT NULL,
    isid bigint DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    name character varying(255) NOT NULL,
    data bytea NOT NULL,
    CONSTRAINT image_effects_ieid_check CHECK ((ieid >= 0)),
    CONSTRAINT image_effects_isid_check CHECK ((isid >= 0))
);


ALTER TABLE public.image_effects OWNER TO drupal;

--
-- Name: TABLE image_effects; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.image_effects IS 'Stores configuration options for image effects.';


--
-- Name: COLUMN image_effects.ieid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.image_effects.ieid IS 'The primary identifier for an image effect.';


--
-- Name: COLUMN image_effects.isid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.image_effects.isid IS 'The image_styles.isid for an image style.';


--
-- Name: COLUMN image_effects.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.image_effects.weight IS 'The weight of the effect in the style.';


--
-- Name: COLUMN image_effects.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.image_effects.name IS 'The unique name of the effect to be executed.';


--
-- Name: COLUMN image_effects.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.image_effects.data IS 'The configuration data for the effect.';


--
-- Name: image_effects_ieid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.image_effects_ieid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_effects_ieid_seq OWNER TO drupal;

--
-- Name: image_effects_ieid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.image_effects_ieid_seq OWNED BY public.image_effects.ieid;


--
-- Name: image_styles; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.image_styles (
    isid integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT image_styles_isid_check CHECK ((isid >= 0))
);


ALTER TABLE public.image_styles OWNER TO drupal;

--
-- Name: TABLE image_styles; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.image_styles IS 'Stores configuration options for image styles.';


--
-- Name: COLUMN image_styles.isid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.image_styles.isid IS 'The primary identifier for an image style.';


--
-- Name: COLUMN image_styles.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.image_styles.name IS 'The style machine name.';


--
-- Name: COLUMN image_styles.label; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.image_styles.label IS 'The style administrative name.';


--
-- Name: image_styles_isid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.image_styles_isid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_styles_isid_seq OWNER TO drupal;

--
-- Name: image_styles_isid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.image_styles_isid_seq OWNED BY public.image_styles.isid;


--
-- Name: menu_custom; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.menu_custom (
    menu_name character varying(32) DEFAULT ''::character varying NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    description text
);


ALTER TABLE public.menu_custom OWNER TO drupal;

--
-- Name: TABLE menu_custom; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.menu_custom IS 'Holds definitions for top-level custom menus (for example, Main menu).';


--
-- Name: COLUMN menu_custom.menu_name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_custom.menu_name IS 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.';


--
-- Name: COLUMN menu_custom.title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_custom.title IS 'Menu title; displayed at top of block.';


--
-- Name: COLUMN menu_custom.description; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_custom.description IS 'Menu description.';


--
-- Name: menu_links; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.menu_links (
    menu_name character varying(32) DEFAULT ''::character varying NOT NULL,
    mlid integer NOT NULL,
    plid bigint DEFAULT 0 NOT NULL,
    link_path character varying(255) DEFAULT ''::character varying NOT NULL,
    router_path character varying(255) DEFAULT ''::character varying NOT NULL,
    link_title character varying(255) DEFAULT ''::character varying NOT NULL,
    options bytea,
    module character varying(255) DEFAULT 'system'::character varying NOT NULL,
    hidden smallint DEFAULT 0 NOT NULL,
    external smallint DEFAULT 0 NOT NULL,
    has_children smallint DEFAULT 0 NOT NULL,
    expanded smallint DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    depth smallint DEFAULT 0 NOT NULL,
    customized smallint DEFAULT 0 NOT NULL,
    p1 bigint DEFAULT 0 NOT NULL,
    p2 bigint DEFAULT 0 NOT NULL,
    p3 bigint DEFAULT 0 NOT NULL,
    p4 bigint DEFAULT 0 NOT NULL,
    p5 bigint DEFAULT 0 NOT NULL,
    p6 bigint DEFAULT 0 NOT NULL,
    p7 bigint DEFAULT 0 NOT NULL,
    p8 bigint DEFAULT 0 NOT NULL,
    p9 bigint DEFAULT 0 NOT NULL,
    updated smallint DEFAULT 0 NOT NULL,
    CONSTRAINT menu_links_mlid_check CHECK ((mlid >= 0)),
    CONSTRAINT menu_links_p1_check CHECK ((p1 >= 0)),
    CONSTRAINT menu_links_p2_check CHECK ((p2 >= 0)),
    CONSTRAINT menu_links_p3_check CHECK ((p3 >= 0)),
    CONSTRAINT menu_links_p4_check CHECK ((p4 >= 0)),
    CONSTRAINT menu_links_p5_check CHECK ((p5 >= 0)),
    CONSTRAINT menu_links_p6_check CHECK ((p6 >= 0)),
    CONSTRAINT menu_links_p7_check CHECK ((p7 >= 0)),
    CONSTRAINT menu_links_p8_check CHECK ((p8 >= 0)),
    CONSTRAINT menu_links_p9_check CHECK ((p9 >= 0)),
    CONSTRAINT menu_links_plid_check CHECK ((plid >= 0))
);


ALTER TABLE public.menu_links OWNER TO drupal;

--
-- Name: TABLE menu_links; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.menu_links IS 'Contains the individual links within a menu.';


--
-- Name: COLUMN menu_links.menu_name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.menu_name IS 'The menu name. All links with the same menu name (such as ''navigation'') are part of the same menu.';


--
-- Name: COLUMN menu_links.mlid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.mlid IS 'The menu link ID (mlid) is the integer primary key.';


--
-- Name: COLUMN menu_links.plid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.plid IS 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.';


--
-- Name: COLUMN menu_links.link_path; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.link_path IS 'The Drupal path or external path this link points to.';


--
-- Name: COLUMN menu_links.router_path; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.router_path IS 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.';


--
-- Name: COLUMN menu_links.link_title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.link_title IS 'The text displayed for the link, which may be modified by a title callback stored in menu_router.';


--
-- Name: COLUMN menu_links.options; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.options IS 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.';


--
-- Name: COLUMN menu_links.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.module IS 'The name of the module that generated this link.';


--
-- Name: COLUMN menu_links.hidden; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.hidden IS 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)';


--
-- Name: COLUMN menu_links.external; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.external IS 'A flag to indicate if the link points to a full URL starting with a protocol,::text like http:// (1 = external, 0 = internal).';


--
-- Name: COLUMN menu_links.has_children; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.has_children IS 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).';


--
-- Name: COLUMN menu_links.expanded; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.expanded IS 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)';


--
-- Name: COLUMN menu_links.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.weight IS 'Link weight among links in the same menu at the same depth.';


--
-- Name: COLUMN menu_links.depth; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.depth IS 'The depth relative to the top level. A link with plid == 0 will have depth == 1.';


--
-- Name: COLUMN menu_links.customized; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.customized IS 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).';


--
-- Name: COLUMN menu_links.p1; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.p1 IS 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.';


--
-- Name: COLUMN menu_links.p2; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.p2 IS 'The second mlid in the materialized path. See p1.';


--
-- Name: COLUMN menu_links.p3; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.p3 IS 'The third mlid in the materialized path. See p1.';


--
-- Name: COLUMN menu_links.p4; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.p4 IS 'The fourth mlid in the materialized path. See p1.';


--
-- Name: COLUMN menu_links.p5; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.p5 IS 'The fifth mlid in the materialized path. See p1.';


--
-- Name: COLUMN menu_links.p6; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.p6 IS 'The sixth mlid in the materialized path. See p1.';


--
-- Name: COLUMN menu_links.p7; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.p7 IS 'The seventh mlid in the materialized path. See p1.';


--
-- Name: COLUMN menu_links.p8; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.p8 IS 'The eighth mlid in the materialized path. See p1.';


--
-- Name: COLUMN menu_links.p9; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.p9 IS 'The ninth mlid in the materialized path. See p1.';


--
-- Name: COLUMN menu_links.updated; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_links.updated IS 'Flag that indicates that this link was generated during the update from Drupal 5.';


--
-- Name: menu_links_mlid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.menu_links_mlid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_links_mlid_seq OWNER TO drupal;

--
-- Name: menu_links_mlid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.menu_links_mlid_seq OWNED BY public.menu_links.mlid;


--
-- Name: menu_router; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.menu_router (
    path character varying(255) DEFAULT ''::character varying NOT NULL,
    load_functions bytea NOT NULL,
    to_arg_functions bytea NOT NULL,
    access_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    access_arguments bytea,
    page_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    page_arguments bytea,
    delivery_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    fit integer DEFAULT 0 NOT NULL,
    number_parts smallint DEFAULT 0 NOT NULL,
    context integer DEFAULT 0 NOT NULL,
    tab_parent character varying(255) DEFAULT ''::character varying NOT NULL,
    tab_root character varying(255) DEFAULT ''::character varying NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    title_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    title_arguments character varying(255) DEFAULT ''::character varying NOT NULL,
    theme_callback character varying(255) DEFAULT ''::character varying NOT NULL,
    theme_arguments character varying(255) DEFAULT ''::character varying NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    description text NOT NULL,
    "position" character varying(255) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    include_file text
);


ALTER TABLE public.menu_router OWNER TO drupal;

--
-- Name: TABLE menu_router; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.menu_router IS 'Maps paths to various callbacks (access, page and title)';


--
-- Name: COLUMN menu_router.path; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.path IS 'Primary Key: the Drupal path this entry describes';


--
-- Name: COLUMN menu_router.load_functions; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.load_functions IS 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.';


--
-- Name: COLUMN menu_router.to_arg_functions; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.to_arg_functions IS 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.';


--
-- Name: COLUMN menu_router.access_callback; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.access_callback IS 'The callback which determines the access to this router path. Defaults to user_access.';


--
-- Name: COLUMN menu_router.access_arguments; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.access_arguments IS 'A serialized array of arguments for the access callback.';


--
-- Name: COLUMN menu_router.page_callback; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.page_callback IS 'The name of the function that renders the page.';


--
-- Name: COLUMN menu_router.page_arguments; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.page_arguments IS 'A serialized array of arguments for the page callback.';


--
-- Name: COLUMN menu_router.delivery_callback; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.delivery_callback IS 'The name of the function that sends the result of the page_callback function to the browser.';


--
-- Name: COLUMN menu_router.fit; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.fit IS 'A numeric representation of how specific the path is.';


--
-- Name: COLUMN menu_router.number_parts; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.number_parts IS 'Number of parts in this router path.';


--
-- Name: COLUMN menu_router.context; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.context IS 'Only for local tasks (tabs) - the context of a local task to control its placement.';


--
-- Name: COLUMN menu_router.tab_parent; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.tab_parent IS 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).';


--
-- Name: COLUMN menu_router.tab_root; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.tab_root IS 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.';


--
-- Name: COLUMN menu_router.title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.title IS 'The title for the current page, or the title for the tab if this is a local task.';


--
-- Name: COLUMN menu_router.title_callback; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.title_callback IS 'A function which will alter the title. Defaults to t()';


--
-- Name: COLUMN menu_router.title_arguments; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.title_arguments IS 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.';


--
-- Name: COLUMN menu_router.theme_callback; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.theme_callback IS 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.';


--
-- Name: COLUMN menu_router.theme_arguments; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.theme_arguments IS 'A serialized array of arguments for the theme callback.';


--
-- Name: COLUMN menu_router.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.type IS 'Numeric representation of the type of the menu item,::text like MENU_LOCAL_TASK.';


--
-- Name: COLUMN menu_router.description; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.description IS 'A description of this item.';


--
-- Name: COLUMN menu_router."position"; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router."position" IS 'The position of the block (left or right) on the system administration page for this item.';


--
-- Name: COLUMN menu_router.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.weight IS 'Weight of the element. Lighter weights are higher up, heavier weights go down.';


--
-- Name: COLUMN menu_router.include_file; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.menu_router.include_file IS 'The file to include for this element, usually the page callback function lives in this file.';


--
-- Name: node; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.node (
    nid integer NOT NULL,
    vid bigint,
    type character varying(32) DEFAULT ''::character varying NOT NULL,
    language character varying(12) DEFAULT ''::character varying NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    changed integer DEFAULT 0 NOT NULL,
    comment integer DEFAULT 0 NOT NULL,
    promote integer DEFAULT 0 NOT NULL,
    sticky integer DEFAULT 0 NOT NULL,
    tnid bigint DEFAULT 0 NOT NULL,
    translate integer DEFAULT 0 NOT NULL,
    CONSTRAINT node_nid_check CHECK ((nid >= 0)),
    CONSTRAINT node_tnid_check CHECK ((tnid >= 0)),
    CONSTRAINT node_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.node OWNER TO drupal;

--
-- Name: TABLE node; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.node IS 'The base table for nodes.';


--
-- Name: COLUMN node.nid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.nid IS 'The primary identifier for a node.';


--
-- Name: COLUMN node.vid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.vid IS 'The current node_revision.vid version identifier.';


--
-- Name: COLUMN node.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.type IS 'The node_type.type of this node.';


--
-- Name: COLUMN node.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.language IS 'The languages.language of this node.';


--
-- Name: COLUMN node.title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.title IS 'The title of this node, always treated as non-markup plain text.';


--
-- Name: COLUMN node.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.uid IS 'The users.uid that owns this node; initially, this is the user that created it.';


--
-- Name: COLUMN node.status; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.status IS 'Boolean indicating whether the node is published (visible to non-administrators).';


--
-- Name: COLUMN node.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.created IS 'The Unix timestamp when the node was created.';


--
-- Name: COLUMN node.changed; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.changed IS 'The Unix timestamp when the node was most recently saved.';


--
-- Name: COLUMN node.comment; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.comment IS 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).';


--
-- Name: COLUMN node.promote; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.promote IS 'Boolean indicating whether the node should be displayed on the front page.';


--
-- Name: COLUMN node.sticky; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.sticky IS 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.';


--
-- Name: COLUMN node.tnid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.tnid IS 'The translation set id for this node, which equals the node id of the source post in each set.';


--
-- Name: COLUMN node.translate; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node.translate IS 'A boolean indicating whether this translation page needs to be updated.';


--
-- Name: node_access; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.node_access (
    nid bigint DEFAULT 0 NOT NULL,
    gid bigint DEFAULT 0 NOT NULL,
    realm character varying(255) DEFAULT ''::character varying NOT NULL,
    grant_view integer DEFAULT 0 NOT NULL,
    grant_update integer DEFAULT 0 NOT NULL,
    grant_delete integer DEFAULT 0 NOT NULL,
    CONSTRAINT node_access_gid_check CHECK ((gid >= 0)),
    CONSTRAINT node_access_grant_delete_check CHECK ((grant_delete >= 0)),
    CONSTRAINT node_access_grant_update_check CHECK ((grant_update >= 0)),
    CONSTRAINT node_access_grant_view_check CHECK ((grant_view >= 0)),
    CONSTRAINT node_access_nid_check CHECK ((nid >= 0))
);


ALTER TABLE public.node_access OWNER TO drupal;

--
-- Name: TABLE node_access; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.node_access IS 'Identifies which realm/grant pairs a user must possess in order to view, update, or delete specific nodes.';


--
-- Name: COLUMN node_access.nid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_access.nid IS 'The node.nid this record affects.';


--
-- Name: COLUMN node_access.gid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_access.gid IS 'The grant ID a user must possess in the specified realm to gain this row''s privileges on the node.';


--
-- Name: COLUMN node_access.realm; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_access.realm IS 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.';


--
-- Name: COLUMN node_access.grant_view; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_access.grant_view IS 'Boolean indicating whether a user with the realm/grant pair can view this node.';


--
-- Name: COLUMN node_access.grant_update; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_access.grant_update IS 'Boolean indicating whether a user with the realm/grant pair can edit this node.';


--
-- Name: COLUMN node_access.grant_delete; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_access.grant_delete IS 'Boolean indicating whether a user with the realm/grant pair can delete this node.';


--
-- Name: node_comment_statistics; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.node_comment_statistics (
    nid bigint DEFAULT 0 NOT NULL,
    cid integer DEFAULT 0 NOT NULL,
    last_comment_timestamp integer DEFAULT 0 NOT NULL,
    last_comment_name character varying(60),
    last_comment_uid integer DEFAULT 0 NOT NULL,
    comment_count bigint DEFAULT 0 NOT NULL,
    CONSTRAINT node_comment_statistics_comment_count_check CHECK ((comment_count >= 0)),
    CONSTRAINT node_comment_statistics_nid_check CHECK ((nid >= 0))
);


ALTER TABLE public.node_comment_statistics OWNER TO drupal;

--
-- Name: TABLE node_comment_statistics; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.node_comment_statistics IS 'Maintains statistics of node and comments posts to show "new" and "updated" flags.';


--
-- Name: COLUMN node_comment_statistics.nid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_comment_statistics.nid IS 'The node.nid for which the statistics are compiled.';


--
-- Name: COLUMN node_comment_statistics.cid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_comment_statistics.cid IS 'The comment.cid of the last comment.';


--
-- Name: COLUMN node_comment_statistics.last_comment_timestamp; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_comment_statistics.last_comment_timestamp IS 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.';


--
-- Name: COLUMN node_comment_statistics.last_comment_name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_comment_statistics.last_comment_name IS 'The name of the latest author to post a comment on this node, from comment.name.';


--
-- Name: COLUMN node_comment_statistics.last_comment_uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_comment_statistics.last_comment_uid IS 'The user ID of the latest author to post a comment on this node, from comment.uid.';


--
-- Name: COLUMN node_comment_statistics.comment_count; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_comment_statistics.comment_count IS 'The total number of comments on this node.';


--
-- Name: node_nid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.node_nid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.node_nid_seq OWNER TO drupal;

--
-- Name: node_nid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.node_nid_seq OWNED BY public.node.nid;


--
-- Name: node_revision; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.node_revision (
    nid bigint DEFAULT 0 NOT NULL,
    vid integer NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    log text NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    comment integer DEFAULT 0 NOT NULL,
    promote integer DEFAULT 0 NOT NULL,
    sticky integer DEFAULT 0 NOT NULL,
    CONSTRAINT node_revision_nid_check CHECK ((nid >= 0)),
    CONSTRAINT node_revision_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.node_revision OWNER TO drupal;

--
-- Name: TABLE node_revision; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.node_revision IS 'Stores information about each saved version of a node.';


--
-- Name: COLUMN node_revision.nid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision.nid IS 'The node this version belongs to.';


--
-- Name: COLUMN node_revision.vid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision.vid IS 'The primary identifier for this version.';


--
-- Name: COLUMN node_revision.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision.uid IS 'The users.uid that created this version.';


--
-- Name: COLUMN node_revision.title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision.title IS 'The title of this version.';


--
-- Name: COLUMN node_revision.log; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision.log IS 'The log entry explaining the changes in this version.';


--
-- Name: COLUMN node_revision."timestamp"; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision."timestamp" IS 'A Unix timestamp indicating when this version was created.';


--
-- Name: COLUMN node_revision.status; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision.status IS 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).';


--
-- Name: COLUMN node_revision.comment; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision.comment IS 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).';


--
-- Name: COLUMN node_revision.promote; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision.promote IS 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.';


--
-- Name: COLUMN node_revision.sticky; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_revision.sticky IS 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.';


--
-- Name: node_revision_vid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.node_revision_vid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.node_revision_vid_seq OWNER TO drupal;

--
-- Name: node_revision_vid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.node_revision_vid_seq OWNED BY public.node_revision.vid;


--
-- Name: node_type; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.node_type (
    type character varying(32) NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    base character varying(255) NOT NULL,
    module character varying(255) NOT NULL,
    description text NOT NULL,
    help text NOT NULL,
    has_title integer NOT NULL,
    title_label character varying(255) DEFAULT ''::character varying NOT NULL,
    custom smallint DEFAULT 0 NOT NULL,
    modified smallint DEFAULT 0 NOT NULL,
    locked smallint DEFAULT 0 NOT NULL,
    disabled smallint DEFAULT 0 NOT NULL,
    orig_type character varying(255) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT node_type_has_title_check CHECK ((has_title >= 0))
);


ALTER TABLE public.node_type OWNER TO drupal;

--
-- Name: TABLE node_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.node_type IS 'Stores information about all defined node types.';


--
-- Name: COLUMN node_type.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.type IS 'The machine-readable name of this type.';


--
-- Name: COLUMN node_type.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.name IS 'The human-readable name of this type.';


--
-- Name: COLUMN node_type.base; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.base IS 'The base string used to construct callbacks corresponding to this node type.';


--
-- Name: COLUMN node_type.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.module IS 'The module defining this node type.';


--
-- Name: COLUMN node_type.description; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.description IS 'A brief description of this type.';


--
-- Name: COLUMN node_type.help; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.help IS 'Help information shown to the user when creating a node of this type.';


--
-- Name: COLUMN node_type.has_title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.has_title IS 'Boolean indicating whether this type uses the node.title field.';


--
-- Name: COLUMN node_type.title_label; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.title_label IS 'The label displayed for the title field on the edit form.';


--
-- Name: COLUMN node_type.custom; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.custom IS 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).';


--
-- Name: COLUMN node_type.modified; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.modified IS 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.';


--
-- Name: COLUMN node_type.locked; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.locked IS 'A boolean indicating whether the administrator can change the machine name of this type.';


--
-- Name: COLUMN node_type.disabled; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.disabled IS 'A boolean indicating whether the node type is disabled.';


--
-- Name: COLUMN node_type.orig_type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.node_type.orig_type IS 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.';


--
-- Name: queue; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.queue (
    item_id integer NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    data bytea,
    expire integer DEFAULT 0 NOT NULL,
    created integer DEFAULT 0 NOT NULL,
    CONSTRAINT queue_item_id_check CHECK ((item_id >= 0))
);


ALTER TABLE public.queue OWNER TO drupal;

--
-- Name: TABLE queue; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.queue IS 'Stores items in queues.';


--
-- Name: COLUMN queue.item_id; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.queue.item_id IS 'Primary Key: Unique item ID.';


--
-- Name: COLUMN queue.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.queue.name IS 'The queue name.';


--
-- Name: COLUMN queue.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.queue.data IS 'The arbitrary data for the item.';


--
-- Name: COLUMN queue.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.queue.expire IS 'Timestamp when the claim lease expires on the item.';


--
-- Name: COLUMN queue.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.queue.created IS 'Timestamp when the item was created.';


--
-- Name: queue_item_id_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.queue_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queue_item_id_seq OWNER TO drupal;

--
-- Name: queue_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.queue_item_id_seq OWNED BY public.queue.item_id;


--
-- Name: rdf_mapping; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.rdf_mapping (
    type character varying(128) NOT NULL,
    bundle character varying(128) NOT NULL,
    mapping bytea
);


ALTER TABLE public.rdf_mapping OWNER TO drupal;

--
-- Name: TABLE rdf_mapping; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.rdf_mapping IS 'Stores custom RDF mappings for user defined content types or overriden module-defined mappings';


--
-- Name: COLUMN rdf_mapping.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.rdf_mapping.type IS 'The name of the entity type a mapping applies to (node, user, comment, etc.).';


--
-- Name: COLUMN rdf_mapping.bundle; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.rdf_mapping.bundle IS 'The name of the bundle a mapping applies to.';


--
-- Name: COLUMN rdf_mapping.mapping; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.rdf_mapping.mapping IS 'The serialized mapping of the bundle type and fields to RDF terms.';


--
-- Name: registry; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.registry (
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    type character varying(9) DEFAULT ''::character varying NOT NULL,
    filename character varying(255) NOT NULL,
    module character varying(255) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.registry OWNER TO drupal;

--
-- Name: TABLE registry; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.registry IS 'Each record is a function, class, or interface name and the file it is in.';


--
-- Name: COLUMN registry.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.registry.name IS 'The name of the function, class, or interface.';


--
-- Name: COLUMN registry.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.registry.type IS 'Either function or class or interface.';


--
-- Name: COLUMN registry.filename; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.registry.filename IS 'Name of the file.';


--
-- Name: COLUMN registry.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.registry.module IS 'Name of the module the file belongs to.';


--
-- Name: COLUMN registry.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.registry.weight IS 'The order in which this module''s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.';


--
-- Name: registry_file; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.registry_file (
    filename character varying(255) NOT NULL,
    hash character varying(64) NOT NULL
);


ALTER TABLE public.registry_file OWNER TO drupal;

--
-- Name: TABLE registry_file; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.registry_file IS 'Files parsed to build the registry.';


--
-- Name: COLUMN registry_file.filename; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.registry_file.filename IS 'Path to the file.';


--
-- Name: COLUMN registry_file.hash; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.registry_file.hash IS 'sha-256 hash of the file''s contents when last parsed.';


--
-- Name: role; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.role (
    rid integer NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    CONSTRAINT role_rid_check CHECK ((rid >= 0))
);


ALTER TABLE public.role OWNER TO drupal;

--
-- Name: TABLE role; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.role IS 'Stores user roles.';


--
-- Name: COLUMN role.rid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.role.rid IS 'Primary Key: Unique role ID.';


--
-- Name: COLUMN role.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.role.name IS 'Unique role name.';


--
-- Name: COLUMN role.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.role.weight IS 'The weight of this role in listings and the user interface.';


--
-- Name: role_permission; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.role_permission (
    rid bigint NOT NULL,
    permission character varying(128) DEFAULT ''::character varying NOT NULL,
    module character varying(255) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT role_permission_rid_check CHECK ((rid >= 0))
);


ALTER TABLE public.role_permission OWNER TO drupal;

--
-- Name: TABLE role_permission; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.role_permission IS 'Stores the permissions assigned to user roles.';


--
-- Name: COLUMN role_permission.rid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.role_permission.rid IS 'Foreign Key: role.rid.';


--
-- Name: COLUMN role_permission.permission; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.role_permission.permission IS 'A single permission granted to the role identified by rid.';


--
-- Name: COLUMN role_permission.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.role_permission.module IS 'The module declaring the permission.';


--
-- Name: role_rid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.role_rid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_rid_seq OWNER TO drupal;

--
-- Name: role_rid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.role_rid_seq OWNED BY public.role.rid;


--
-- Name: search_dataset; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.search_dataset (
    sid bigint DEFAULT 0 NOT NULL,
    type character varying(16) NOT NULL,
    data text NOT NULL,
    reindex bigint DEFAULT 0 NOT NULL,
    CONSTRAINT search_dataset_reindex_check CHECK ((reindex >= 0)),
    CONSTRAINT search_dataset_sid_check CHECK ((sid >= 0))
);


ALTER TABLE public.search_dataset OWNER TO drupal;

--
-- Name: TABLE search_dataset; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.search_dataset IS 'Stores items that will be searched.';


--
-- Name: COLUMN search_dataset.sid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_dataset.sid IS 'Search item ID, e.g. node ID for nodes.';


--
-- Name: COLUMN search_dataset.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_dataset.type IS 'Type of item, e.g. node.';


--
-- Name: COLUMN search_dataset.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_dataset.data IS 'List of space-separated words from the item.';


--
-- Name: COLUMN search_dataset.reindex; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_dataset.reindex IS 'Set to force node reindexing.';


--
-- Name: search_index; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.search_index (
    word character varying(50) DEFAULT ''::character varying NOT NULL,
    sid bigint DEFAULT 0 NOT NULL,
    type character varying(16) NOT NULL,
    score real,
    CONSTRAINT search_index_sid_check CHECK ((sid >= 0))
);


ALTER TABLE public.search_index OWNER TO drupal;

--
-- Name: TABLE search_index; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.search_index IS 'Stores the search index, associating words, items and scores.';


--
-- Name: COLUMN search_index.word; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_index.word IS 'The search_total.word that is associated with the search item.';


--
-- Name: COLUMN search_index.sid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_index.sid IS 'The search_dataset.sid of the searchable item to which the word belongs.';


--
-- Name: COLUMN search_index.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_index.type IS 'The search_dataset.type of the searchable item to which the word belongs.';


--
-- Name: COLUMN search_index.score; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_index.score IS 'The numeric score of the word, higher being more important.';


--
-- Name: search_node_links; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.search_node_links (
    sid bigint DEFAULT 0 NOT NULL,
    type character varying(16) DEFAULT ''::character varying NOT NULL,
    nid bigint DEFAULT 0 NOT NULL,
    caption text,
    CONSTRAINT search_node_links_nid_check CHECK ((nid >= 0)),
    CONSTRAINT search_node_links_sid_check CHECK ((sid >= 0))
);


ALTER TABLE public.search_node_links OWNER TO drupal;

--
-- Name: TABLE search_node_links; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.search_node_links IS 'Stores items (like nodes) that link to other nodes, used to improve search scores for nodes that are frequently linked to.';


--
-- Name: COLUMN search_node_links.sid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_node_links.sid IS 'The search_dataset.sid of the searchable item containing the link to the node.';


--
-- Name: COLUMN search_node_links.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_node_links.type IS 'The search_dataset.type of the searchable item containing the link to the node.';


--
-- Name: COLUMN search_node_links.nid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_node_links.nid IS 'The node.nid that this item links to.';


--
-- Name: COLUMN search_node_links.caption; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_node_links.caption IS 'The text used to link to the node.nid.';


--
-- Name: search_total; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.search_total (
    word character varying(50) DEFAULT ''::character varying NOT NULL,
    count real
);


ALTER TABLE public.search_total OWNER TO drupal;

--
-- Name: TABLE search_total; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.search_total IS 'Stores search totals for words.';


--
-- Name: COLUMN search_total.word; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_total.word IS 'Primary Key: Unique word in the search index.';


--
-- Name: COLUMN search_total.count; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.search_total.count IS 'The count of the word in the index using Zipf''s law to equalize the probability distribution.';


--
-- Name: semaphore; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.semaphore (
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL,
    expire double precision NOT NULL
);


ALTER TABLE public.semaphore OWNER TO drupal;

--
-- Name: TABLE semaphore; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.semaphore IS 'Table for holding semaphores, locks, flags, etc. that cannot be stored as Drupal variables since they must not be cached.';


--
-- Name: COLUMN semaphore.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.semaphore.name IS 'Primary Key: Unique name.';


--
-- Name: COLUMN semaphore.value; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.semaphore.value IS 'A value for the semaphore.';


--
-- Name: COLUMN semaphore.expire; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.semaphore.expire IS 'A Unix timestamp with microseconds indicating when the semaphore should expire.';


--
-- Name: sequences; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.sequences (
    value integer NOT NULL,
    CONSTRAINT sequences_value_check CHECK ((value >= 0))
);


ALTER TABLE public.sequences OWNER TO drupal;

--
-- Name: TABLE sequences; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.sequences IS 'Stores IDs.';


--
-- Name: COLUMN sequences.value; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.sequences.value IS 'The value of the sequence.';


--
-- Name: sequences_value_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.sequences_value_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sequences_value_seq OWNER TO drupal;

--
-- Name: sequences_value_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.sequences_value_seq OWNED BY public.sequences.value;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.sessions (
    uid bigint NOT NULL,
    sid character varying(128) NOT NULL,
    ssid character varying(128) DEFAULT ''::character varying NOT NULL,
    hostname character varying(128) DEFAULT ''::character varying NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    cache integer DEFAULT 0 NOT NULL,
    session bytea,
    CONSTRAINT sessions_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.sessions OWNER TO drupal;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.sessions IS 'Drupal''s session handlers read and write into the sessions table. Each record represents a user session, either anonymous or authenticated.';


--
-- Name: COLUMN sessions.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.sessions.uid IS 'The users.uid corresponding to a session, or 0 for anonymous user.';


--
-- Name: COLUMN sessions.sid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.sessions.sid IS 'A session ID. The value is generated by Drupal''s session handlers.';


--
-- Name: COLUMN sessions.ssid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.sessions.ssid IS 'Secure session ID. The value is generated by Drupal''s session handlers.';


--
-- Name: COLUMN sessions.hostname; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.sessions.hostname IS 'The IP address that last used this session ID (sid).';


--
-- Name: COLUMN sessions."timestamp"; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.sessions."timestamp" IS 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.';


--
-- Name: COLUMN sessions.cache; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.sessions.cache IS 'The time of this user''s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().';


--
-- Name: COLUMN sessions.session; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.sessions.session IS 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.';


--
-- Name: shortcut_set; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.shortcut_set (
    set_name character varying(32) DEFAULT ''::character varying NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.shortcut_set OWNER TO drupal;

--
-- Name: TABLE shortcut_set; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.shortcut_set IS 'Stores information about sets of shortcuts links.';


--
-- Name: COLUMN shortcut_set.set_name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.shortcut_set.set_name IS 'Primary Key: The menu_links.menu_name under which the set''s links are stored.';


--
-- Name: COLUMN shortcut_set.title; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.shortcut_set.title IS 'The title of the set.';


--
-- Name: shortcut_set_users; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.shortcut_set_users (
    uid bigint DEFAULT 0 NOT NULL,
    set_name character varying(32) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT shortcut_set_users_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.shortcut_set_users OWNER TO drupal;

--
-- Name: TABLE shortcut_set_users; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.shortcut_set_users IS 'Maps users to shortcut sets.';


--
-- Name: COLUMN shortcut_set_users.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.shortcut_set_users.uid IS 'The users.uid for this set.';


--
-- Name: COLUMN shortcut_set_users.set_name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.shortcut_set_users.set_name IS 'The shortcut_set.set_name that will be displayed for this user.';


--
-- Name: system; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.system (
    filename character varying(255) DEFAULT ''::character varying NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    type character varying(12) DEFAULT ''::character varying NOT NULL,
    owner character varying(255) DEFAULT ''::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    bootstrap integer DEFAULT 0 NOT NULL,
    schema_version smallint DEFAULT '-1'::integer NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    info bytea
);


ALTER TABLE public.system OWNER TO drupal;

--
-- Name: TABLE system; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.system IS 'A list of all modules, themes, and theme engines that are or have been installed in Drupal''s file system.';


--
-- Name: COLUMN system.filename; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.system.filename IS 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.';


--
-- Name: COLUMN system.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.system.name IS 'The name of the item; e.g. node.';


--
-- Name: COLUMN system.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.system.type IS 'The type of the item, either module, theme, or theme_engine.';


--
-- Name: COLUMN system.owner; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.system.owner IS 'A theme''s ''parent'' . Can be either a theme or an engine.';


--
-- Name: COLUMN system.status; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.system.status IS 'Boolean indicating whether or not this item is enabled.';


--
-- Name: COLUMN system.bootstrap; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.system.bootstrap IS 'Boolean indicating whether this module is loaded during Drupal''s early bootstrapping phase (e.g. even before the page cache is consulted).';


--
-- Name: COLUMN system.schema_version; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.system.schema_version IS 'The module''s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module''s hook_update_N() function that has either been run or existed when the module was first installed.';


--
-- Name: COLUMN system.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.system.weight IS 'The order in which this module''s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.';


--
-- Name: COLUMN system.info; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.system.info IS 'A serialized array containing information from the module''s .info file; keys can include name, description, package, version, core, dependencies, and php.';


--
-- Name: taxonomy_index; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.taxonomy_index (
    nid bigint DEFAULT 0 NOT NULL,
    tid bigint DEFAULT 0 NOT NULL,
    sticky smallint DEFAULT 0,
    created integer DEFAULT 0 NOT NULL,
    CONSTRAINT taxonomy_index_nid_check CHECK ((nid >= 0)),
    CONSTRAINT taxonomy_index_tid_check CHECK ((tid >= 0))
);


ALTER TABLE public.taxonomy_index OWNER TO drupal;

--
-- Name: TABLE taxonomy_index; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.taxonomy_index IS 'Maintains denormalized information about node/term relationships.';


--
-- Name: COLUMN taxonomy_index.nid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_index.nid IS 'The node.nid this record tracks.';


--
-- Name: COLUMN taxonomy_index.tid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_index.tid IS 'The term ID.';


--
-- Name: COLUMN taxonomy_index.sticky; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_index.sticky IS 'Boolean indicating whether the node is sticky.';


--
-- Name: COLUMN taxonomy_index.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_index.created IS 'The Unix timestamp when the node was created.';


--
-- Name: taxonomy_term_data; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.taxonomy_term_data (
    tid integer NOT NULL,
    vid bigint DEFAULT 0 NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    description text,
    format character varying(255),
    weight integer DEFAULT 0 NOT NULL,
    CONSTRAINT taxonomy_term_data_tid_check CHECK ((tid >= 0)),
    CONSTRAINT taxonomy_term_data_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.taxonomy_term_data OWNER TO drupal;

--
-- Name: TABLE taxonomy_term_data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.taxonomy_term_data IS 'Stores term information.';


--
-- Name: COLUMN taxonomy_term_data.tid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_term_data.tid IS 'Primary Key: Unique term ID.';


--
-- Name: COLUMN taxonomy_term_data.vid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_term_data.vid IS 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.';


--
-- Name: COLUMN taxonomy_term_data.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_term_data.name IS 'The term name.';


--
-- Name: COLUMN taxonomy_term_data.description; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_term_data.description IS 'A description of the term.';


--
-- Name: COLUMN taxonomy_term_data.format; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_term_data.format IS 'The filter_format.format of the description.';


--
-- Name: COLUMN taxonomy_term_data.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_term_data.weight IS 'The weight of this term in relation to other terms.';


--
-- Name: taxonomy_term_data_tid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.taxonomy_term_data_tid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taxonomy_term_data_tid_seq OWNER TO drupal;

--
-- Name: taxonomy_term_data_tid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.taxonomy_term_data_tid_seq OWNED BY public.taxonomy_term_data.tid;


--
-- Name: taxonomy_term_hierarchy; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.taxonomy_term_hierarchy (
    tid bigint DEFAULT 0 NOT NULL,
    parent bigint DEFAULT 0 NOT NULL,
    CONSTRAINT taxonomy_term_hierarchy_parent_check CHECK ((parent >= 0)),
    CONSTRAINT taxonomy_term_hierarchy_tid_check CHECK ((tid >= 0))
);


ALTER TABLE public.taxonomy_term_hierarchy OWNER TO drupal;

--
-- Name: TABLE taxonomy_term_hierarchy; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.taxonomy_term_hierarchy IS 'Stores the hierarchical relationship between terms.';


--
-- Name: COLUMN taxonomy_term_hierarchy.tid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_term_hierarchy.tid IS 'Primary Key: The taxonomy_term_data.tid of the term.';


--
-- Name: COLUMN taxonomy_term_hierarchy.parent; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_term_hierarchy.parent IS 'Primary Key: The taxonomy_term_data.tid of the term''s parent. 0 indicates no parent.';


--
-- Name: taxonomy_vocabulary; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.taxonomy_vocabulary (
    vid integer NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    machine_name character varying(255) DEFAULT ''::character varying NOT NULL,
    description text,
    hierarchy integer DEFAULT 0 NOT NULL,
    module character varying(255) DEFAULT ''::character varying NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    CONSTRAINT taxonomy_vocabulary_hierarchy_check CHECK ((hierarchy >= 0)),
    CONSTRAINT taxonomy_vocabulary_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.taxonomy_vocabulary OWNER TO drupal;

--
-- Name: TABLE taxonomy_vocabulary; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.taxonomy_vocabulary IS 'Stores vocabulary information.';


--
-- Name: COLUMN taxonomy_vocabulary.vid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_vocabulary.vid IS 'Primary Key: Unique vocabulary ID.';


--
-- Name: COLUMN taxonomy_vocabulary.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_vocabulary.name IS 'Name of the vocabulary.';


--
-- Name: COLUMN taxonomy_vocabulary.machine_name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_vocabulary.machine_name IS 'The vocabulary machine name.';


--
-- Name: COLUMN taxonomy_vocabulary.description; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_vocabulary.description IS 'Description of the vocabulary.';


--
-- Name: COLUMN taxonomy_vocabulary.hierarchy; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_vocabulary.hierarchy IS 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)';


--
-- Name: COLUMN taxonomy_vocabulary.module; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_vocabulary.module IS 'The module which created the vocabulary.';


--
-- Name: COLUMN taxonomy_vocabulary.weight; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.taxonomy_vocabulary.weight IS 'The weight of this vocabulary in relation to other vocabularies.';


--
-- Name: taxonomy_vocabulary_vid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.taxonomy_vocabulary_vid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taxonomy_vocabulary_vid_seq OWNER TO drupal;

--
-- Name: taxonomy_vocabulary_vid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.taxonomy_vocabulary_vid_seq OWNED BY public.taxonomy_vocabulary.vid;


--
-- Name: url_alias; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.url_alias (
    pid integer NOT NULL,
    source character varying(255) DEFAULT ''::character varying NOT NULL,
    alias character varying(255) DEFAULT ''::character varying NOT NULL,
    language character varying(12) DEFAULT ''::character varying NOT NULL,
    CONSTRAINT url_alias_pid_check CHECK ((pid >= 0))
);


ALTER TABLE public.url_alias OWNER TO drupal;

--
-- Name: TABLE url_alias; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.url_alias IS 'A list of URL aliases for Drupal paths; a user may visit either the source or destination path.';


--
-- Name: COLUMN url_alias.pid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.url_alias.pid IS 'A unique path alias identifier.';


--
-- Name: COLUMN url_alias.source; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.url_alias.source IS 'The Drupal path this alias is for; e.g. node/12.';


--
-- Name: COLUMN url_alias.alias; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.url_alias.alias IS 'The alias for this path; e.g. title-of-the-story.';


--
-- Name: COLUMN url_alias.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.url_alias.language IS 'The language this alias is for; if ''und'', the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.';


--
-- Name: url_alias_pid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.url_alias_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.url_alias_pid_seq OWNER TO drupal;

--
-- Name: url_alias_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.url_alias_pid_seq OWNED BY public.url_alias.pid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.users (
    uid bigint DEFAULT 0 NOT NULL,
    name character varying(60) DEFAULT ''::character varying NOT NULL,
    pass character varying(128) DEFAULT ''::character varying NOT NULL,
    mail character varying(254) DEFAULT ''::character varying,
    theme character varying(255) DEFAULT ''::character varying NOT NULL,
    signature character varying(255) DEFAULT ''::character varying NOT NULL,
    signature_format character varying(255),
    created integer DEFAULT 0 NOT NULL,
    access integer DEFAULT 0 NOT NULL,
    login integer DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    timezone character varying(32),
    language character varying(12) DEFAULT ''::character varying NOT NULL,
    picture integer DEFAULT 0 NOT NULL,
    init character varying(254) DEFAULT ''::character varying,
    data bytea,
    CONSTRAINT users_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.users OWNER TO drupal;

--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.users IS 'Stores user data.';


--
-- Name: COLUMN users.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.uid IS 'Primary Key: Unique user ID.';


--
-- Name: COLUMN users.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.name IS 'Unique user name.';


--
-- Name: COLUMN users.pass; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.pass IS 'User''s password (hashed).';


--
-- Name: COLUMN users.mail; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.mail IS 'User''s e-mail address.';


--
-- Name: COLUMN users.theme; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.theme IS 'User''s default theme.';


--
-- Name: COLUMN users.signature; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.signature IS 'User''s signature.';


--
-- Name: COLUMN users.signature_format; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.signature_format IS 'The filter_format.format of the signature.';


--
-- Name: COLUMN users.created; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.created IS 'Timestamp for when user was created.';


--
-- Name: COLUMN users.access; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.access IS 'Timestamp for previous time user accessed the site.';


--
-- Name: COLUMN users.login; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.login IS 'Timestamp for user''s last login.';


--
-- Name: COLUMN users.status; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.status IS 'Whether the user is active(1) or blocked(0).';


--
-- Name: COLUMN users.timezone; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.timezone IS 'User''s time zone.';


--
-- Name: COLUMN users.language; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.language IS 'User''s default language.';


--
-- Name: COLUMN users.picture; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.picture IS 'Foreign key: file_managed.fid of user''s picture.';


--
-- Name: COLUMN users.init; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.init IS 'E-mail address used for initial account creation.';


--
-- Name: COLUMN users.data; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users.data IS 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future version of Drupal.';


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.users_roles (
    uid bigint DEFAULT 0 NOT NULL,
    rid bigint DEFAULT 0 NOT NULL,
    CONSTRAINT users_roles_rid_check CHECK ((rid >= 0)),
    CONSTRAINT users_roles_uid_check CHECK ((uid >= 0))
);


ALTER TABLE public.users_roles OWNER TO drupal;

--
-- Name: TABLE users_roles; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.users_roles IS 'Maps users to roles.';


--
-- Name: COLUMN users_roles.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users_roles.uid IS 'Primary Key: users.uid for user.';


--
-- Name: COLUMN users_roles.rid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.users_roles.rid IS 'Primary Key: role.rid for role.';


--
-- Name: variable; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.variable (
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    value bytea NOT NULL
);


ALTER TABLE public.variable OWNER TO drupal;

--
-- Name: TABLE variable; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.variable IS 'Named variable/value pairs created by Drupal core or any other module or theme. All variables are cached in memory at the start of every Drupal request so developers should not be careless about what is stored here.';


--
-- Name: COLUMN variable.name; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.variable.name IS 'The name of the variable.';


--
-- Name: COLUMN variable.value; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.variable.value IS 'The value of the variable.';


--
-- Name: watchdog; Type: TABLE; Schema: public; Owner: drupal
--

CREATE TABLE public.watchdog (
    wid integer NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    type character varying(64) DEFAULT ''::character varying NOT NULL,
    message text NOT NULL,
    variables bytea NOT NULL,
    severity integer DEFAULT 0 NOT NULL,
    link character varying(255) DEFAULT ''::character varying,
    location text NOT NULL,
    referer text,
    hostname character varying(128) DEFAULT ''::character varying NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    CONSTRAINT watchdog_severity_check CHECK ((severity >= 0))
);


ALTER TABLE public.watchdog OWNER TO drupal;

--
-- Name: TABLE watchdog; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON TABLE public.watchdog IS 'Table that contains logs of all system events.';


--
-- Name: COLUMN watchdog.wid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.wid IS 'Primary Key: Unique watchdog event ID.';


--
-- Name: COLUMN watchdog.uid; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.uid IS 'The users.uid of the user who triggered the event.';


--
-- Name: COLUMN watchdog.type; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.type IS 'Type of log message, for example "user" or "page not found."';


--
-- Name: COLUMN watchdog.message; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.message IS 'Text of log message to be passed into the t() function.';


--
-- Name: COLUMN watchdog.variables; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.variables IS 'Serialized array of variables that match the message string and that is passed into the t() function.';


--
-- Name: COLUMN watchdog.severity; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.severity IS 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)';


--
-- Name: COLUMN watchdog.link; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.link IS 'Link to view the result of the event.';


--
-- Name: COLUMN watchdog.location; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.location IS 'URL of the origin of the event.';


--
-- Name: COLUMN watchdog.referer; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.referer IS 'URL of referring page.';


--
-- Name: COLUMN watchdog.hostname; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog.hostname IS 'Hostname of the user who triggered the event.';


--
-- Name: COLUMN watchdog."timestamp"; Type: COMMENT; Schema: public; Owner: drupal
--

COMMENT ON COLUMN public.watchdog."timestamp" IS 'Unix timestamp of when event occurred.';


--
-- Name: watchdog_wid_seq; Type: SEQUENCE; Schema: public; Owner: drupal
--

CREATE SEQUENCE public.watchdog_wid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watchdog_wid_seq OWNER TO drupal;

--
-- Name: watchdog_wid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: drupal
--

ALTER SEQUENCE public.watchdog_wid_seq OWNED BY public.watchdog.wid;


--
-- Name: authmap aid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.authmap ALTER COLUMN aid SET DEFAULT nextval('public.authmap_aid_seq'::regclass);


--
-- Name: block bid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.block ALTER COLUMN bid SET DEFAULT nextval('public.block_bid_seq'::regclass);


--
-- Name: block_custom bid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.block_custom ALTER COLUMN bid SET DEFAULT nextval('public.block_custom_bid_seq'::regclass);


--
-- Name: blocked_ips iid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.blocked_ips ALTER COLUMN iid SET DEFAULT nextval('public.blocked_ips_iid_seq'::regclass);


--
-- Name: comment cid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.comment ALTER COLUMN cid SET DEFAULT nextval('public.comment_cid_seq'::regclass);


--
-- Name: date_formats dfid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.date_formats ALTER COLUMN dfid SET DEFAULT nextval('public.date_formats_dfid_seq'::regclass);


--
-- Name: field_config id; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_config ALTER COLUMN id SET DEFAULT nextval('public.field_config_id_seq'::regclass);


--
-- Name: field_config_instance id; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_config_instance ALTER COLUMN id SET DEFAULT nextval('public.field_config_instance_id_seq'::regclass);


--
-- Name: file_managed fid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.file_managed ALTER COLUMN fid SET DEFAULT nextval('public.file_managed_fid_seq'::regclass);


--
-- Name: flood fid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.flood ALTER COLUMN fid SET DEFAULT nextval('public.flood_fid_seq'::regclass);


--
-- Name: image_effects ieid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.image_effects ALTER COLUMN ieid SET DEFAULT nextval('public.image_effects_ieid_seq'::regclass);


--
-- Name: image_styles isid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.image_styles ALTER COLUMN isid SET DEFAULT nextval('public.image_styles_isid_seq'::regclass);


--
-- Name: menu_links mlid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.menu_links ALTER COLUMN mlid SET DEFAULT nextval('public.menu_links_mlid_seq'::regclass);


--
-- Name: node nid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.node ALTER COLUMN nid SET DEFAULT nextval('public.node_nid_seq'::regclass);


--
-- Name: node_revision vid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.node_revision ALTER COLUMN vid SET DEFAULT nextval('public.node_revision_vid_seq'::regclass);


--
-- Name: queue item_id; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.queue ALTER COLUMN item_id SET DEFAULT nextval('public.queue_item_id_seq'::regclass);


--
-- Name: role rid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.role ALTER COLUMN rid SET DEFAULT nextval('public.role_rid_seq'::regclass);


--
-- Name: sequences value; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.sequences ALTER COLUMN value SET DEFAULT nextval('public.sequences_value_seq'::regclass);


--
-- Name: taxonomy_term_data tid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.taxonomy_term_data ALTER COLUMN tid SET DEFAULT nextval('public.taxonomy_term_data_tid_seq'::regclass);


--
-- Name: taxonomy_vocabulary vid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.taxonomy_vocabulary ALTER COLUMN vid SET DEFAULT nextval('public.taxonomy_vocabulary_vid_seq'::regclass);


--
-- Name: url_alias pid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.url_alias ALTER COLUMN pid SET DEFAULT nextval('public.url_alias_pid_seq'::regclass);


--
-- Name: watchdog wid; Type: DEFAULT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.watchdog ALTER COLUMN wid SET DEFAULT nextval('public.watchdog_wid_seq'::regclass);


--
-- Name: actions actions_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (aid);


--
-- Name: authmap authmap_authname_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.authmap
    ADD CONSTRAINT authmap_authname_key UNIQUE (authname);


--
-- Name: authmap authmap_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.authmap
    ADD CONSTRAINT authmap_pkey PRIMARY KEY (aid);


--
-- Name: batch batch_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.batch
    ADD CONSTRAINT batch_pkey PRIMARY KEY (bid);


--
-- Name: block_custom block_custom_info_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.block_custom
    ADD CONSTRAINT block_custom_info_key UNIQUE (info);


--
-- Name: block_custom block_custom_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.block_custom
    ADD CONSTRAINT block_custom_pkey PRIMARY KEY (bid);


--
-- Name: block_node_type block_node_type_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.block_node_type
    ADD CONSTRAINT block_node_type_pkey PRIMARY KEY (module, delta, type);


--
-- Name: block block_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.block
    ADD CONSTRAINT block_pkey PRIMARY KEY (bid);


--
-- Name: block_role block_role_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.block_role
    ADD CONSTRAINT block_role_pkey PRIMARY KEY (module, delta, rid);


--
-- Name: block block_tmd_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.block
    ADD CONSTRAINT block_tmd_key UNIQUE (theme, module, delta);


--
-- Name: blocked_ips blocked_ips_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.blocked_ips
    ADD CONSTRAINT blocked_ips_pkey PRIMARY KEY (iid);


--
-- Name: cache_block cache_block_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_block
    ADD CONSTRAINT cache_block_pkey PRIMARY KEY (cid);


--
-- Name: cache_bootstrap cache_bootstrap_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_bootstrap
    ADD CONSTRAINT cache_bootstrap_pkey PRIMARY KEY (cid);


--
-- Name: cache_field cache_field_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_field
    ADD CONSTRAINT cache_field_pkey PRIMARY KEY (cid);


--
-- Name: cache_filter cache_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_filter
    ADD CONSTRAINT cache_filter_pkey PRIMARY KEY (cid);


--
-- Name: cache_form cache_form_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_form
    ADD CONSTRAINT cache_form_pkey PRIMARY KEY (cid);


--
-- Name: cache_image cache_image_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_image
    ADD CONSTRAINT cache_image_pkey PRIMARY KEY (cid);


--
-- Name: cache_menu cache_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_menu
    ADD CONSTRAINT cache_menu_pkey PRIMARY KEY (cid);


--
-- Name: cache_page cache_page_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_page
    ADD CONSTRAINT cache_page_pkey PRIMARY KEY (cid);


--
-- Name: cache_path cache_path_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_path
    ADD CONSTRAINT cache_path_pkey PRIMARY KEY (cid);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (cid);


--
-- Name: cache_update cache_update_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.cache_update
    ADD CONSTRAINT cache_update_pkey PRIMARY KEY (cid);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (cid);


--
-- Name: date_format_locale date_format_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.date_format_locale
    ADD CONSTRAINT date_format_locale_pkey PRIMARY KEY (type, language);


--
-- Name: date_format_type date_format_type_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.date_format_type
    ADD CONSTRAINT date_format_type_pkey PRIMARY KEY (type);


--
-- Name: date_formats date_formats_formats_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.date_formats
    ADD CONSTRAINT date_formats_formats_key UNIQUE (format, type);


--
-- Name: date_formats date_formats_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.date_formats
    ADD CONSTRAINT date_formats_pkey PRIMARY KEY (dfid);


--
-- Name: field_config_instance field_config_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_config_instance
    ADD CONSTRAINT field_config_instance_pkey PRIMARY KEY (id);


--
-- Name: field_config field_config_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_config
    ADD CONSTRAINT field_config_pkey PRIMARY KEY (id);


--
-- Name: field_data_body field_data_body_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_data_body
    ADD CONSTRAINT field_data_body_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- Name: field_data_comment_body field_data_comment_body_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_data_comment_body
    ADD CONSTRAINT field_data_comment_body_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- Name: field_data_field_image field_data_field_image_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_data_field_image
    ADD CONSTRAINT field_data_field_image_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- Name: field_data_field_tags field_data_field_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_data_field_tags
    ADD CONSTRAINT field_data_field_tags_pkey PRIMARY KEY (entity_type, entity_id, deleted, delta, language);


--
-- Name: field_revision_body field_revision_body_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_revision_body
    ADD CONSTRAINT field_revision_body_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- Name: field_revision_comment_body field_revision_comment_body_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_revision_comment_body
    ADD CONSTRAINT field_revision_comment_body_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- Name: field_revision_field_image field_revision_field_image_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_revision_field_image
    ADD CONSTRAINT field_revision_field_image_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- Name: field_revision_field_tags field_revision_field_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.field_revision_field_tags
    ADD CONSTRAINT field_revision_field_tags_pkey PRIMARY KEY (entity_type, entity_id, revision_id, deleted, delta, language);


--
-- Name: file_managed file_managed_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.file_managed
    ADD CONSTRAINT file_managed_pkey PRIMARY KEY (fid);


--
-- Name: file_managed file_managed_uri_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.file_managed
    ADD CONSTRAINT file_managed_uri_key UNIQUE (uri);


--
-- Name: file_usage file_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.file_usage
    ADD CONSTRAINT file_usage_pkey PRIMARY KEY (fid, type, id, module);


--
-- Name: filter_format filter_format_name_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.filter_format
    ADD CONSTRAINT filter_format_name_key UNIQUE (name);


--
-- Name: filter_format filter_format_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.filter_format
    ADD CONSTRAINT filter_format_pkey PRIMARY KEY (format);


--
-- Name: filter filter_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.filter
    ADD CONSTRAINT filter_pkey PRIMARY KEY (format, name);


--
-- Name: flood flood_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.flood
    ADD CONSTRAINT flood_pkey PRIMARY KEY (fid);


--
-- Name: history history_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (uid, nid);


--
-- Name: image_effects image_effects_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.image_effects
    ADD CONSTRAINT image_effects_pkey PRIMARY KEY (ieid);


--
-- Name: image_styles image_styles_name_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.image_styles
    ADD CONSTRAINT image_styles_name_key UNIQUE (name);


--
-- Name: image_styles image_styles_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.image_styles
    ADD CONSTRAINT image_styles_pkey PRIMARY KEY (isid);


--
-- Name: menu_custom menu_custom_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.menu_custom
    ADD CONSTRAINT menu_custom_pkey PRIMARY KEY (menu_name);


--
-- Name: menu_links menu_links_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.menu_links
    ADD CONSTRAINT menu_links_pkey PRIMARY KEY (mlid);


--
-- Name: menu_router menu_router_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.menu_router
    ADD CONSTRAINT menu_router_pkey PRIMARY KEY (path);


--
-- Name: node_access node_access_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.node_access
    ADD CONSTRAINT node_access_pkey PRIMARY KEY (nid, gid, realm);


--
-- Name: node_comment_statistics node_comment_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.node_comment_statistics
    ADD CONSTRAINT node_comment_statistics_pkey PRIMARY KEY (nid);


--
-- Name: node node_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT node_pkey PRIMARY KEY (nid);


--
-- Name: node_revision node_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.node_revision
    ADD CONSTRAINT node_revision_pkey PRIMARY KEY (vid);


--
-- Name: node_type node_type_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.node_type
    ADD CONSTRAINT node_type_pkey PRIMARY KEY (type);


--
-- Name: node node_vid_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT node_vid_key UNIQUE (vid);


--
-- Name: queue queue_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.queue
    ADD CONSTRAINT queue_pkey PRIMARY KEY (item_id);


--
-- Name: rdf_mapping rdf_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.rdf_mapping
    ADD CONSTRAINT rdf_mapping_pkey PRIMARY KEY (type, bundle);


--
-- Name: registry_file registry_file_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.registry_file
    ADD CONSTRAINT registry_file_pkey PRIMARY KEY (filename);


--
-- Name: registry registry_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.registry
    ADD CONSTRAINT registry_pkey PRIMARY KEY (name, type);


--
-- Name: role role_name_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role_permission role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (rid, permission);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (rid);


--
-- Name: search_dataset search_dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.search_dataset
    ADD CONSTRAINT search_dataset_pkey PRIMARY KEY (sid, type);


--
-- Name: search_index search_index_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.search_index
    ADD CONSTRAINT search_index_pkey PRIMARY KEY (word, sid, type);


--
-- Name: search_node_links search_node_links_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.search_node_links
    ADD CONSTRAINT search_node_links_pkey PRIMARY KEY (sid, type, nid);


--
-- Name: search_total search_total_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.search_total
    ADD CONSTRAINT search_total_pkey PRIMARY KEY (word);


--
-- Name: semaphore semaphore_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.semaphore
    ADD CONSTRAINT semaphore_pkey PRIMARY KEY (name);


--
-- Name: sequences sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.sequences
    ADD CONSTRAINT sequences_pkey PRIMARY KEY (value);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid, ssid);


--
-- Name: shortcut_set shortcut_set_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.shortcut_set
    ADD CONSTRAINT shortcut_set_pkey PRIMARY KEY (set_name);


--
-- Name: shortcut_set_users shortcut_set_users_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.shortcut_set_users
    ADD CONSTRAINT shortcut_set_users_pkey PRIMARY KEY (uid);


--
-- Name: system system_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.system
    ADD CONSTRAINT system_pkey PRIMARY KEY (filename);


--
-- Name: taxonomy_term_data taxonomy_term_data_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.taxonomy_term_data
    ADD CONSTRAINT taxonomy_term_data_pkey PRIMARY KEY (tid);


--
-- Name: taxonomy_term_hierarchy taxonomy_term_hierarchy_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.taxonomy_term_hierarchy
    ADD CONSTRAINT taxonomy_term_hierarchy_pkey PRIMARY KEY (tid, parent);


--
-- Name: taxonomy_vocabulary taxonomy_vocabulary_machine_name_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.taxonomy_vocabulary
    ADD CONSTRAINT taxonomy_vocabulary_machine_name_key UNIQUE (machine_name);


--
-- Name: taxonomy_vocabulary taxonomy_vocabulary_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.taxonomy_vocabulary
    ADD CONSTRAINT taxonomy_vocabulary_pkey PRIMARY KEY (vid);


--
-- Name: url_alias url_alias_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.url_alias
    ADD CONSTRAINT url_alias_pkey PRIMARY KEY (pid);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);


--
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (uid, rid);


--
-- Name: variable variable_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.variable
    ADD CONSTRAINT variable_pkey PRIMARY KEY (name);


--
-- Name: watchdog watchdog_pkey; Type: CONSTRAINT; Schema: public; Owner: drupal
--

ALTER TABLE ONLY public.watchdog
    ADD CONSTRAINT watchdog_pkey PRIMARY KEY (wid);


--
-- Name: authmap_uid_module_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX authmap_uid_module_idx ON public.authmap USING btree (uid, module);


--
-- Name: batch_token_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX batch_token_idx ON public.batch USING btree (token);


--
-- Name: block_list_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX block_list_idx ON public.block USING btree (theme, status, region, weight, module);


--
-- Name: block_node_type_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX block_node_type_type_idx ON public.block_node_type USING btree (type);


--
-- Name: block_role_rid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX block_role_rid_idx ON public.block_role USING btree (rid);


--
-- Name: blocked_ips_blocked_ip_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX blocked_ips_blocked_ip_idx ON public.blocked_ips USING btree (ip);


--
-- Name: cache_block_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_block_expire_idx ON public.cache_block USING btree (expire);


--
-- Name: cache_bootstrap_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_bootstrap_expire_idx ON public.cache_bootstrap USING btree (expire);


--
-- Name: cache_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_expire_idx ON public.cache USING btree (expire);


--
-- Name: cache_field_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_field_expire_idx ON public.cache_field USING btree (expire);


--
-- Name: cache_filter_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_filter_expire_idx ON public.cache_filter USING btree (expire);


--
-- Name: cache_form_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_form_expire_idx ON public.cache_form USING btree (expire);


--
-- Name: cache_image_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_image_expire_idx ON public.cache_image USING btree (expire);


--
-- Name: cache_menu_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_menu_expire_idx ON public.cache_menu USING btree (expire);


--
-- Name: cache_page_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_page_expire_idx ON public.cache_page USING btree (expire);


--
-- Name: cache_path_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_path_expire_idx ON public.cache_path USING btree (expire);


--
-- Name: cache_update_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX cache_update_expire_idx ON public.cache_update USING btree (expire);


--
-- Name: comment_comment_created_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX comment_comment_created_idx ON public.comment USING btree (created);


--
-- Name: comment_comment_nid_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX comment_comment_nid_language_idx ON public.comment USING btree (nid, language);


--
-- Name: comment_comment_num_new_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX comment_comment_num_new_idx ON public.comment USING btree (nid, status, created, cid, thread);


--
-- Name: comment_comment_status_pid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX comment_comment_status_pid_idx ON public.comment USING btree (pid, status);


--
-- Name: comment_comment_uid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX comment_comment_uid_idx ON public.comment USING btree (uid);


--
-- Name: date_format_type_title_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX date_format_type_title_idx ON public.date_format_type USING btree (title);


--
-- Name: field_config_active_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_active_idx ON public.field_config USING btree (active);


--
-- Name: field_config_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_deleted_idx ON public.field_config USING btree (deleted);


--
-- Name: field_config_field_name_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_field_name_idx ON public.field_config USING btree (field_name);


--
-- Name: field_config_instance_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_instance_deleted_idx ON public.field_config_instance USING btree (deleted);


--
-- Name: field_config_instance_field_name_bundle_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_instance_field_name_bundle_idx ON public.field_config_instance USING btree (field_name, entity_type, bundle);


--
-- Name: field_config_module_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_module_idx ON public.field_config USING btree (module);


--
-- Name: field_config_storage_active_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_storage_active_idx ON public.field_config USING btree (storage_active);


--
-- Name: field_config_storage_module_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_storage_module_idx ON public.field_config USING btree (storage_module);


--
-- Name: field_config_storage_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_storage_type_idx ON public.field_config USING btree (storage_type);


--
-- Name: field_config_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_config_type_idx ON public.field_config USING btree (type);


--
-- Name: field_data_body_body_format_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_body_body_format_idx ON public.field_data_body USING btree (body_format);


--
-- Name: field_data_body_bundle_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_body_bundle_idx ON public.field_data_body USING btree (bundle);


--
-- Name: field_data_body_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_body_deleted_idx ON public.field_data_body USING btree (deleted);


--
-- Name: field_data_body_entity_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_body_entity_id_idx ON public.field_data_body USING btree (entity_id);


--
-- Name: field_data_body_entity_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_body_entity_type_idx ON public.field_data_body USING btree (entity_type);


--
-- Name: field_data_body_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_body_language_idx ON public.field_data_body USING btree (language);


--
-- Name: field_data_body_revision_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_body_revision_id_idx ON public.field_data_body USING btree (revision_id);


--
-- Name: field_data_comment_body_bundle_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_comment_body_bundle_idx ON public.field_data_comment_body USING btree (bundle);


--
-- Name: field_data_comment_body_comment_body_format_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_comment_body_comment_body_format_idx ON public.field_data_comment_body USING btree (comment_body_format);


--
-- Name: field_data_comment_body_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_comment_body_deleted_idx ON public.field_data_comment_body USING btree (deleted);


--
-- Name: field_data_comment_body_entity_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_comment_body_entity_id_idx ON public.field_data_comment_body USING btree (entity_id);


--
-- Name: field_data_comment_body_entity_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_comment_body_entity_type_idx ON public.field_data_comment_body USING btree (entity_type);


--
-- Name: field_data_comment_body_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_comment_body_language_idx ON public.field_data_comment_body USING btree (language);


--
-- Name: field_data_comment_body_revision_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_comment_body_revision_id_idx ON public.field_data_comment_body USING btree (revision_id);


--
-- Name: field_data_field_image_bundle_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_image_bundle_idx ON public.field_data_field_image USING btree (bundle);


--
-- Name: field_data_field_image_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_image_deleted_idx ON public.field_data_field_image USING btree (deleted);


--
-- Name: field_data_field_image_entity_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_image_entity_id_idx ON public.field_data_field_image USING btree (entity_id);


--
-- Name: field_data_field_image_entity_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_image_entity_type_idx ON public.field_data_field_image USING btree (entity_type);


--
-- Name: field_data_field_image_field_image_fid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_image_field_image_fid_idx ON public.field_data_field_image USING btree (field_image_fid);


--
-- Name: field_data_field_image_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_image_language_idx ON public.field_data_field_image USING btree (language);


--
-- Name: field_data_field_image_revision_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_image_revision_id_idx ON public.field_data_field_image USING btree (revision_id);


--
-- Name: field_data_field_tags_bundle_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_tags_bundle_idx ON public.field_data_field_tags USING btree (bundle);


--
-- Name: field_data_field_tags_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_tags_deleted_idx ON public.field_data_field_tags USING btree (deleted);


--
-- Name: field_data_field_tags_entity_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_tags_entity_id_idx ON public.field_data_field_tags USING btree (entity_id);


--
-- Name: field_data_field_tags_entity_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_tags_entity_type_idx ON public.field_data_field_tags USING btree (entity_type);


--
-- Name: field_data_field_tags_field_tags_tid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_tags_field_tags_tid_idx ON public.field_data_field_tags USING btree (field_tags_tid);


--
-- Name: field_data_field_tags_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_tags_language_idx ON public.field_data_field_tags USING btree (language);


--
-- Name: field_data_field_tags_revision_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_data_field_tags_revision_id_idx ON public.field_data_field_tags USING btree (revision_id);


--
-- Name: field_revision_body_body_format_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_body_body_format_idx ON public.field_revision_body USING btree (body_format);


--
-- Name: field_revision_body_bundle_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_body_bundle_idx ON public.field_revision_body USING btree (bundle);


--
-- Name: field_revision_body_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_body_deleted_idx ON public.field_revision_body USING btree (deleted);


--
-- Name: field_revision_body_entity_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_body_entity_id_idx ON public.field_revision_body USING btree (entity_id);


--
-- Name: field_revision_body_entity_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_body_entity_type_idx ON public.field_revision_body USING btree (entity_type);


--
-- Name: field_revision_body_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_body_language_idx ON public.field_revision_body USING btree (language);


--
-- Name: field_revision_body_revision_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_body_revision_id_idx ON public.field_revision_body USING btree (revision_id);


--
-- Name: field_revision_comment_body_bundle_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_comment_body_bundle_idx ON public.field_revision_comment_body USING btree (bundle);


--
-- Name: field_revision_comment_body_comment_body_format_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_comment_body_comment_body_format_idx ON public.field_revision_comment_body USING btree (comment_body_format);


--
-- Name: field_revision_comment_body_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_comment_body_deleted_idx ON public.field_revision_comment_body USING btree (deleted);


--
-- Name: field_revision_comment_body_entity_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_comment_body_entity_id_idx ON public.field_revision_comment_body USING btree (entity_id);


--
-- Name: field_revision_comment_body_entity_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_comment_body_entity_type_idx ON public.field_revision_comment_body USING btree (entity_type);


--
-- Name: field_revision_comment_body_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_comment_body_language_idx ON public.field_revision_comment_body USING btree (language);


--
-- Name: field_revision_comment_body_revision_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_comment_body_revision_id_idx ON public.field_revision_comment_body USING btree (revision_id);


--
-- Name: field_revision_field_image_bundle_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_image_bundle_idx ON public.field_revision_field_image USING btree (bundle);


--
-- Name: field_revision_field_image_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_image_deleted_idx ON public.field_revision_field_image USING btree (deleted);


--
-- Name: field_revision_field_image_entity_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_image_entity_id_idx ON public.field_revision_field_image USING btree (entity_id);


--
-- Name: field_revision_field_image_entity_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_image_entity_type_idx ON public.field_revision_field_image USING btree (entity_type);


--
-- Name: field_revision_field_image_field_image_fid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_image_field_image_fid_idx ON public.field_revision_field_image USING btree (field_image_fid);


--
-- Name: field_revision_field_image_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_image_language_idx ON public.field_revision_field_image USING btree (language);


--
-- Name: field_revision_field_image_revision_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_image_revision_id_idx ON public.field_revision_field_image USING btree (revision_id);


--
-- Name: field_revision_field_tags_bundle_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_tags_bundle_idx ON public.field_revision_field_tags USING btree (bundle);


--
-- Name: field_revision_field_tags_deleted_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_tags_deleted_idx ON public.field_revision_field_tags USING btree (deleted);


--
-- Name: field_revision_field_tags_entity_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_tags_entity_id_idx ON public.field_revision_field_tags USING btree (entity_id);


--
-- Name: field_revision_field_tags_entity_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_tags_entity_type_idx ON public.field_revision_field_tags USING btree (entity_type);


--
-- Name: field_revision_field_tags_field_tags_tid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_tags_field_tags_tid_idx ON public.field_revision_field_tags USING btree (field_tags_tid);


--
-- Name: field_revision_field_tags_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_tags_language_idx ON public.field_revision_field_tags USING btree (language);


--
-- Name: field_revision_field_tags_revision_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX field_revision_field_tags_revision_id_idx ON public.field_revision_field_tags USING btree (revision_id);


--
-- Name: file_managed_status_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX file_managed_status_idx ON public.file_managed USING btree (status);


--
-- Name: file_managed_timestamp_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX file_managed_timestamp_idx ON public.file_managed USING btree ("timestamp");


--
-- Name: file_managed_uid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX file_managed_uid_idx ON public.file_managed USING btree (uid);


--
-- Name: file_usage_fid_count_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX file_usage_fid_count_idx ON public.file_usage USING btree (fid, count);


--
-- Name: file_usage_fid_module_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX file_usage_fid_module_idx ON public.file_usage USING btree (fid, module);


--
-- Name: file_usage_type_id_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX file_usage_type_id_idx ON public.file_usage USING btree (type, id);


--
-- Name: filter_format_status_weight_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX filter_format_status_weight_idx ON public.filter_format USING btree (status, weight);


--
-- Name: filter_list_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX filter_list_idx ON public.filter USING btree (weight, module, name);


--
-- Name: flood_allow_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX flood_allow_idx ON public.flood USING btree (event, identifier, "timestamp");


--
-- Name: flood_purge_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX flood_purge_idx ON public.flood USING btree (expiration);


--
-- Name: history_nid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX history_nid_idx ON public.history USING btree (nid);


--
-- Name: image_effects_isid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX image_effects_isid_idx ON public.image_effects USING btree (isid);


--
-- Name: image_effects_weight_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX image_effects_weight_idx ON public.image_effects USING btree (weight);


--
-- Name: menu_links_menu_parents_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX menu_links_menu_parents_idx ON public.menu_links USING btree (menu_name, p1, p2, p3, p4, p5, p6, p7, p8, p9);


--
-- Name: menu_links_menu_plid_expand_child_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX menu_links_menu_plid_expand_child_idx ON public.menu_links USING btree (menu_name, plid, expanded, has_children);


--
-- Name: menu_links_path_menu_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX menu_links_path_menu_idx ON public.menu_links USING btree (substr((link_path)::text, 1, 128), menu_name);


--
-- Name: menu_links_router_path_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX menu_links_router_path_idx ON public.menu_links USING btree (substr((router_path)::text, 1, 128));


--
-- Name: menu_router_fit_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX menu_router_fit_idx ON public.menu_router USING btree (fit);


--
-- Name: menu_router_tab_parent_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX menu_router_tab_parent_idx ON public.menu_router USING btree (substr((tab_parent)::text, 1, 64), weight, title);


--
-- Name: menu_router_tab_root_weight_title_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX menu_router_tab_root_weight_title_idx ON public.menu_router USING btree (substr((tab_root)::text, 1, 64), weight, title);


--
-- Name: node_comment_statistics_comment_count_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_comment_statistics_comment_count_idx ON public.node_comment_statistics USING btree (comment_count);


--
-- Name: node_comment_statistics_last_comment_uid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_comment_statistics_last_comment_uid_idx ON public.node_comment_statistics USING btree (last_comment_uid);


--
-- Name: node_comment_statistics_node_comment_timestamp_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_comment_statistics_node_comment_timestamp_idx ON public.node_comment_statistics USING btree (last_comment_timestamp);


--
-- Name: node_language_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_language_idx ON public.node USING btree (language);


--
-- Name: node_node_changed_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_node_changed_idx ON public.node USING btree (changed);


--
-- Name: node_node_created_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_node_created_idx ON public.node USING btree (created);


--
-- Name: node_node_frontpage_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_node_frontpage_idx ON public.node USING btree (promote, status, sticky, created);


--
-- Name: node_node_status_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_node_status_type_idx ON public.node USING btree (status, type, nid);


--
-- Name: node_node_title_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_node_title_type_idx ON public.node USING btree (title, substr((type)::text, 1, 4));


--
-- Name: node_node_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_node_type_idx ON public.node USING btree (substr((type)::text, 1, 4));


--
-- Name: node_revision_nid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_revision_nid_idx ON public.node_revision USING btree (nid);


--
-- Name: node_revision_uid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_revision_uid_idx ON public.node_revision USING btree (uid);


--
-- Name: node_tnid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_tnid_idx ON public.node USING btree (tnid);


--
-- Name: node_translate_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_translate_idx ON public.node USING btree (translate);


--
-- Name: node_uid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX node_uid_idx ON public.node USING btree (uid);


--
-- Name: queue_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX queue_expire_idx ON public.queue USING btree (expire);


--
-- Name: queue_name_created_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX queue_name_created_idx ON public.queue USING btree (name, created);


--
-- Name: registry_hook_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX registry_hook_idx ON public.registry USING btree (type, weight, module);


--
-- Name: role_name_weight_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX role_name_weight_idx ON public.role USING btree (name, weight);


--
-- Name: role_permission_permission_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX role_permission_permission_idx ON public.role_permission USING btree (permission);


--
-- Name: search_index_sid_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX search_index_sid_type_idx ON public.search_index USING btree (sid, type);


--
-- Name: search_node_links_nid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX search_node_links_nid_idx ON public.search_node_links USING btree (nid);


--
-- Name: semaphore_expire_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX semaphore_expire_idx ON public.semaphore USING btree (expire);


--
-- Name: semaphore_value_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX semaphore_value_idx ON public.semaphore USING btree (value);


--
-- Name: sessions_ssid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX sessions_ssid_idx ON public.sessions USING btree (ssid);


--
-- Name: sessions_timestamp_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX sessions_timestamp_idx ON public.sessions USING btree ("timestamp");


--
-- Name: sessions_uid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX sessions_uid_idx ON public.sessions USING btree (uid);


--
-- Name: shortcut_set_users_set_name_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX shortcut_set_users_set_name_idx ON public.shortcut_set_users USING btree (set_name);


--
-- Name: system_system_list_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX system_system_list_idx ON public.system USING btree (status, bootstrap, type, weight, name);


--
-- Name: system_type_name_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX system_type_name_idx ON public.system USING btree (type, name);


--
-- Name: taxonomy_index_nid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX taxonomy_index_nid_idx ON public.taxonomy_index USING btree (nid);


--
-- Name: taxonomy_index_term_node_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX taxonomy_index_term_node_idx ON public.taxonomy_index USING btree (tid, sticky, created);


--
-- Name: taxonomy_term_data_name_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX taxonomy_term_data_name_idx ON public.taxonomy_term_data USING btree (name);


--
-- Name: taxonomy_term_data_taxonomy_tree_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX taxonomy_term_data_taxonomy_tree_idx ON public.taxonomy_term_data USING btree (vid, weight, name);


--
-- Name: taxonomy_term_data_vid_name_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX taxonomy_term_data_vid_name_idx ON public.taxonomy_term_data USING btree (vid, name);


--
-- Name: taxonomy_term_hierarchy_parent_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX taxonomy_term_hierarchy_parent_idx ON public.taxonomy_term_hierarchy USING btree (parent);


--
-- Name: taxonomy_vocabulary_list_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX taxonomy_vocabulary_list_idx ON public.taxonomy_vocabulary USING btree (weight, name);


--
-- Name: url_alias_alias_language_pid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX url_alias_alias_language_pid_idx ON public.url_alias USING btree (alias, language, pid);


--
-- Name: url_alias_source_language_pid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX url_alias_source_language_pid_idx ON public.url_alias USING btree (source, language, pid);


--
-- Name: users_access_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX users_access_idx ON public.users USING btree (access);


--
-- Name: users_created_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX users_created_idx ON public.users USING btree (created);


--
-- Name: users_mail_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX users_mail_idx ON public.users USING btree (mail);


--
-- Name: users_picture_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX users_picture_idx ON public.users USING btree (picture);


--
-- Name: users_roles_rid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX users_roles_rid_idx ON public.users_roles USING btree (rid);


--
-- Name: watchdog_severity_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX watchdog_severity_idx ON public.watchdog USING btree (severity);


--
-- Name: watchdog_type_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX watchdog_type_idx ON public.watchdog USING btree (type);


--
-- Name: watchdog_uid_idx; Type: INDEX; Schema: public; Owner: drupal
--

CREATE INDEX watchdog_uid_idx ON public.watchdog USING btree (uid);


--
-- PostgreSQL database dump complete
--
