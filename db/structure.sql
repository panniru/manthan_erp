--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admissions (
    id integer NOT NULL,
    admission_no character varying(255),
    branch character varying(255),
    surname character varying(255),
    second_lang character varying(255),
    board character varying(255),
    grade character varying(255),
    medium character varying(255),
    year integer,
    written character varying(255),
    reading character varying(255),
    spoken character varying(255),
    blood_group character varying(255),
    allergy character varying(255),
    doctor_name character varying(255),
    doctor_mobile character varying(255),
    guardian_name character varying(255),
    guardian_mobile character varying(255),
    guardian_relationship character varying(255),
    "from" character varying(255),
    "to" character varying(255),
    middle_name character varying(255),
    name character varying(255),
    klass character varying(255),
    dob character varying(255),
    gender character varying(255),
    nationality character varying(255),
    language character varying(255),
    father_name character varying(255),
    mother_name character varying(255),
    father_occupation character varying(255),
    mother_occupation character varying(255),
    father_company character varying(255),
    mother_company character varying(255),
    father_education character varying(255),
    mother_education character varying(255),
    income character varying(255),
    address text,
    landline character varying(255),
    mobile character varying(255),
    email character varying(255),
    transport character varying(255),
    busstop character varying(255),
    last_school character varying(255),
    city character varying(255),
    changing_reason character varying(255),
    know_school character varying(255),
    person character varying(255),
    pp character varying(255),
    status character varying(255),
    father_office_address character varying(255),
    mother_office_address character varying(255),
    father_office_telephone character varying(255),
    mother_office_telephone character varying(255),
    father_mobile character varying(255),
    mother_mobile character varying(255),
    mother_religion character varying(255),
    father_religion character varying(255),
    father_employer character varying(255),
    mother_employer character varying(255),
    father_email character varying(255),
    mother_email character varying(255),
    sib_name character varying(255),
    sib_age character varying(255),
    sib_sex character varying(255),
    sib_grade character varying(255),
    sib_school character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    avatar character varying(255),
    bus character varying(255),
    form_no character varying(255)
);


--
-- Name: admissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admissions_id_seq OWNED BY admissions.id;


--
-- Name: approvals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE approvals (
    id integer NOT NULL,
    approved character varying(255),
    def_by character varying(255),
    status character varying(255),
    year character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: approvals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE approvals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: approvals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE approvals_id_seq OWNED BY approvals.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: discounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE discounts (
    id integer NOT NULL,
    discount_percent double precision,
    academic_year character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: discounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE discounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE discounts_id_seq OWNED BY discounts.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    title character varying(255),
    description text,
    staff character varying(255),
    grade character varying(255),
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: fee_grade_buckets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fee_grade_buckets (
    id integer NOT NULL,
    grade_from character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    grade_to character varying(255)
);


--
-- Name: fee_grade_buckets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fee_grade_buckets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fee_grade_buckets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fee_grade_buckets_id_seq OWNED BY fee_grade_buckets.id;


--
-- Name: fee_structure_approvals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fee_structure_approvals (
    id integer NOT NULL,
    approved_by character varying(255),
    defined_by character varying(255),
    status character varying(255),
    academic_year character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    fee_type character varying(255)
);


--
-- Name: fee_structure_approvals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fee_structure_approvals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fee_structure_approvals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fee_structure_approvals_id_seq OWNED BY fee_structure_approvals.id;


--
-- Name: fee_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fee_types (
    id integer NOT NULL,
    fee_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: fee_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fee_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fee_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fee_types_id_seq OWNED BY fee_types.id;


--
-- Name: grade_bucket_mappings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE grade_bucket_mappings (
    id integer NOT NULL,
    grade_master_id integer,
    fee_grade_bucket_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: grade_bucket_mappings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE grade_bucket_mappings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grade_bucket_mappings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE grade_bucket_mappings_id_seq OWNED BY grade_bucket_mappings.id;


--
-- Name: grade_bucket_maps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE grade_bucket_maps (
    id integer NOT NULL,
    grade_id integer,
    grade_bucket_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: grade_bucket_maps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE grade_bucket_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grade_bucket_maps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE grade_bucket_maps_id_seq OWNED BY grade_bucket_maps.id;


--
-- Name: grade_masters; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE grade_masters (
    id integer NOT NULL,
    grade_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: grade_masters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE grade_masters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grade_masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE grade_masters_id_seq OWNED BY grade_masters.id;


--
-- Name: grade_wise_fees; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE grade_wise_fees (
    id integer NOT NULL,
    fee_grade_bucket_id integer,
    fee_type_id integer,
    amount_in_rupees integer,
    acedemic_year character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: grade_wise_fees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE grade_wise_fees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grade_wise_fees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE grade_wise_fees_id_seq OWNED BY grade_wise_fees.id;


--
-- Name: job_runs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE job_runs (
    id integer NOT NULL,
    job_id integer,
    started_on timestamp without time zone,
    finished_on timestamp without time zone,
    status character varying(255),
    scrolled_by character varying(255),
    job_date date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: job_runs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE job_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE job_runs_id_seq OWNED BY job_runs.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE jobs (
    id integer NOT NULL,
    code character varying(255),
    description character varying(255),
    job_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE jobs_id_seq OWNED BY jobs.id;


--
-- Name: monthly_pdc_amounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE monthly_pdc_amounts (
    id integer NOT NULL,
    fee_grade_bucket_id integer,
    post_dated_cheque_id integer,
    amount_in_rupees integer,
    academic_year character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: monthly_pdc_amounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE monthly_pdc_amounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: monthly_pdc_amounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE monthly_pdc_amounts_id_seq OWNED BY monthly_pdc_amounts.id;


--
-- Name: parent_cheques; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE parent_cheques (
    id integer NOT NULL,
    parent_id integer,
    student_id integer,
    parent_payment_master_id integer,
    parent_payment_transaction_id integer,
    amount_in_rupees integer,
    cheque_number character varying(255),
    cheque_date date,
    status character varying(255),
    post_dated_cheque_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    bank_name character varying(255),
    ifsc_code character varying(255)
);


--
-- Name: parent_cheques_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE parent_cheques_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parent_cheques_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE parent_cheques_id_seq OWNED BY parent_cheques.id;


--
-- Name: parent_payment_masters; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE parent_payment_masters (
    id integer NOT NULL,
    parent_id integer,
    student_id integer,
    payment_type_id integer,
    next_payment_date date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: parent_payment_masters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE parent_payment_masters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parent_payment_masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE parent_payment_masters_id_seq OWNED BY parent_payment_masters.id;


--
-- Name: parent_payment_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE parent_payment_transactions (
    id integer NOT NULL,
    parent_payment_master_id integer,
    transaction_date date,
    amount_in_rupees integer,
    transaction_type character varying(255),
    particulars character varying(255),
    academic_year character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    term_definition_id integer
);


--
-- Name: parent_payment_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE parent_payment_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parent_payment_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE parent_payment_transactions_id_seq OWNED BY parent_payment_transactions.id;


--
-- Name: parents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE parents (
    id integer NOT NULL,
    father_name character varying(255),
    mother_name character varying(255),
    guardian_name character varying(255),
    father_occupation character varying(255),
    mother_occupation character varying(255),
    guardian_occupation character varying(255),
    father_phone character varying(255),
    mother_phone character varying(255),
    guardian_phone character varying(255),
    father_email character varying(255),
    mother_email character varying(255),
    guardian_email character varying(255),
    address character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: parents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE parents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE parents_id_seq OWNED BY parents.id;


--
-- Name: payment_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payment_types (
    id integer NOT NULL,
    code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: payment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payment_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payment_types_id_seq OWNED BY payment_types.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pg_search_documents (
    id integer NOT NULL,
    content text,
    searchable_id integer,
    searchable_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pg_search_documents_id_seq OWNED BY pg_search_documents.id;


--
-- Name: post_dated_cheques; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_dated_cheques (
    id integer NOT NULL,
    date date,
    month character varying(255),
    academic_year integer,
    amount_per double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: post_dated_cheques_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_dated_cheques_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_dated_cheques_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_dated_cheques_id_seq OWNED BY post_dated_cheques.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    role character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: student_masters; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE student_masters (
    id integer NOT NULL,
    name character varying(255),
    dob date,
    joining_date date,
    academic_year character varying(255),
    parent_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    grade_master_id integer,
    section integer
);


--
-- Name: student_masters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE student_masters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_masters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE student_masters_id_seq OWNED BY student_masters.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE students (
    id integer NOT NULL,
    form_no character varying(255),
    name character varying(255),
    klass character varying(255),
    dob character varying(255),
    gender character varying(255),
    nationality character varying(255),
    language character varying(255),
    father_name character varying(255),
    mother_name character varying(255),
    father_occupation character varying(255),
    mother_occupation character varying(255),
    father_company character varying(255),
    mother_company character varying(255),
    father_education character varying(255),
    mother_education character varying(255),
    income character varying(255),
    address text,
    landline character varying(255),
    mobile character varying(255),
    email character varying(255),
    transport character varying(255),
    busstop character varying(255),
    last_school character varying(255),
    city character varying(255),
    changing_reason character varying(255),
    know_school character varying(255),
    person character varying(255),
    pp character varying(255),
    appno character varying(255),
    status character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: term_definitions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE term_definitions (
    id integer NOT NULL,
    term_definition character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    amount_per double precision,
    termdate character varying(255)
);


--
-- Name: term_definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE term_definitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: term_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE term_definitions_id_seq OWNED BY term_definitions.id;


--
-- Name: term_wise_grade_fees; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE term_wise_grade_fees (
    id integer NOT NULL,
    fee_grade_bucket_id integer,
    term_definition_id integer,
    amount_in_rupees integer,
    academic_year character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: term_wise_grade_fees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE term_wise_grade_fees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: term_wise_grade_fees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE term_wise_grade_fees_id_seq OWNED BY term_wise_grade_fees.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    role_id integer,
    user_id character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admissions ALTER COLUMN id SET DEFAULT nextval('admissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY approvals ALTER COLUMN id SET DEFAULT nextval('approvals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY discounts ALTER COLUMN id SET DEFAULT nextval('discounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fee_grade_buckets ALTER COLUMN id SET DEFAULT nextval('fee_grade_buckets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fee_structure_approvals ALTER COLUMN id SET DEFAULT nextval('fee_structure_approvals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fee_types ALTER COLUMN id SET DEFAULT nextval('fee_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY grade_bucket_mappings ALTER COLUMN id SET DEFAULT nextval('grade_bucket_mappings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY grade_bucket_maps ALTER COLUMN id SET DEFAULT nextval('grade_bucket_maps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY grade_masters ALTER COLUMN id SET DEFAULT nextval('grade_masters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY grade_wise_fees ALTER COLUMN id SET DEFAULT nextval('grade_wise_fees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY job_runs ALTER COLUMN id SET DEFAULT nextval('job_runs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY jobs ALTER COLUMN id SET DEFAULT nextval('jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY monthly_pdc_amounts ALTER COLUMN id SET DEFAULT nextval('monthly_pdc_amounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY parent_cheques ALTER COLUMN id SET DEFAULT nextval('parent_cheques_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY parent_payment_masters ALTER COLUMN id SET DEFAULT nextval('parent_payment_masters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY parent_payment_transactions ALTER COLUMN id SET DEFAULT nextval('parent_payment_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY parents ALTER COLUMN id SET DEFAULT nextval('parents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payment_types ALTER COLUMN id SET DEFAULT nextval('payment_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pg_search_documents ALTER COLUMN id SET DEFAULT nextval('pg_search_documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_dated_cheques ALTER COLUMN id SET DEFAULT nextval('post_dated_cheques_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY student_masters ALTER COLUMN id SET DEFAULT nextval('student_masters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY term_definitions ALTER COLUMN id SET DEFAULT nextval('term_definitions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY term_wise_grade_fees ALTER COLUMN id SET DEFAULT nextval('term_wise_grade_fees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: admissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admissions
    ADD CONSTRAINT admissions_pkey PRIMARY KEY (id);


--
-- Name: approvals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY approvals
    ADD CONSTRAINT approvals_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: fee_grade_buckets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fee_grade_buckets
    ADD CONSTRAINT fee_grade_buckets_pkey PRIMARY KEY (id);


--
-- Name: fee_structure_approvals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fee_structure_approvals
    ADD CONSTRAINT fee_structure_approvals_pkey PRIMARY KEY (id);


--
-- Name: fee_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fee_types
    ADD CONSTRAINT fee_types_pkey PRIMARY KEY (id);


--
-- Name: grade_bucket_mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY grade_bucket_mappings
    ADD CONSTRAINT grade_bucket_mappings_pkey PRIMARY KEY (id);


--
-- Name: grade_bucket_maps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY grade_bucket_maps
    ADD CONSTRAINT grade_bucket_maps_pkey PRIMARY KEY (id);


--
-- Name: grade_masters_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY grade_masters
    ADD CONSTRAINT grade_masters_pkey PRIMARY KEY (id);


--
-- Name: grade_wise_fees_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY grade_wise_fees
    ADD CONSTRAINT grade_wise_fees_pkey PRIMARY KEY (id);


--
-- Name: job_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY job_runs
    ADD CONSTRAINT job_runs_pkey PRIMARY KEY (id);


--
-- Name: jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: monthly_pdc_amounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY monthly_pdc_amounts
    ADD CONSTRAINT monthly_pdc_amounts_pkey PRIMARY KEY (id);


--
-- Name: parent_cheques_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY parent_cheques
    ADD CONSTRAINT parent_cheques_pkey PRIMARY KEY (id);


--
-- Name: parent_payment_masters_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY parent_payment_masters
    ADD CONSTRAINT parent_payment_masters_pkey PRIMARY KEY (id);


--
-- Name: parent_payment_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY parent_payment_transactions
    ADD CONSTRAINT parent_payment_transactions_pkey PRIMARY KEY (id);


--
-- Name: parents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY parents
    ADD CONSTRAINT parents_pkey PRIMARY KEY (id);


--
-- Name: payment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payment_types
    ADD CONSTRAINT payment_types_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: post_dated_cheques_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_dated_cheques
    ADD CONSTRAINT post_dated_cheques_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: student_masters_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY student_masters
    ADD CONSTRAINT student_masters_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: term_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY term_definitions
    ADD CONSTRAINT term_definitions_pkey PRIMARY KEY (id);


--
-- Name: term_wise_grade_fees_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY term_wise_grade_fees
    ADD CONSTRAINT term_wise_grade_fees_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140516045243');

INSERT INTO schema_migrations (version) VALUES ('20140516125102');

INSERT INTO schema_migrations (version) VALUES ('20140519133246');

INSERT INTO schema_migrations (version) VALUES ('20140520133602');

INSERT INTO schema_migrations (version) VALUES ('20140521070808');

INSERT INTO schema_migrations (version) VALUES ('20140521073755');

INSERT INTO schema_migrations (version) VALUES ('20140522052259');

INSERT INTO schema_migrations (version) VALUES ('20140522074734');

INSERT INTO schema_migrations (version) VALUES ('20140522080128');

INSERT INTO schema_migrations (version) VALUES ('20140522123535');

INSERT INTO schema_migrations (version) VALUES ('20140526114428');

INSERT INTO schema_migrations (version) VALUES ('20140527091259');

INSERT INTO schema_migrations (version) VALUES ('20140527115231');

INSERT INTO schema_migrations (version) VALUES ('20140528085423');

INSERT INTO schema_migrations (version) VALUES ('20140528115611');

INSERT INTO schema_migrations (version) VALUES ('20140528121151');

INSERT INTO schema_migrations (version) VALUES ('20140528123929');

INSERT INTO schema_migrations (version) VALUES ('20140529102940');

INSERT INTO schema_migrations (version) VALUES ('20140529104332');

INSERT INTO schema_migrations (version) VALUES ('20140529105755');

INSERT INTO schema_migrations (version) VALUES ('20140602103348');

INSERT INTO schema_migrations (version) VALUES ('20140602121120');

INSERT INTO schema_migrations (version) VALUES ('20140602131101');

INSERT INTO schema_migrations (version) VALUES ('20140603061203');

INSERT INTO schema_migrations (version) VALUES ('20140604052151');

INSERT INTO schema_migrations (version) VALUES ('20140604073805');

INSERT INTO schema_migrations (version) VALUES ('20140604074052');

INSERT INTO schema_migrations (version) VALUES ('20140604091312');

INSERT INTO schema_migrations (version) VALUES ('20140604101947');

INSERT INTO schema_migrations (version) VALUES ('20140605072036');

INSERT INTO schema_migrations (version) VALUES ('20140605072619');

INSERT INTO schema_migrations (version) VALUES ('20140606060954');

INSERT INTO schema_migrations (version) VALUES ('20140606062258');

INSERT INTO schema_migrations (version) VALUES ('20140606111903');

INSERT INTO schema_migrations (version) VALUES ('20140609060900');

INSERT INTO schema_migrations (version) VALUES ('20140609133304');

INSERT INTO schema_migrations (version) VALUES ('20140609133506');

INSERT INTO schema_migrations (version) VALUES ('20140610045045');

INSERT INTO schema_migrations (version) VALUES ('20140610113433');

INSERT INTO schema_migrations (version) VALUES ('20140610113525');

INSERT INTO schema_migrations (version) VALUES ('20140611042313');

INSERT INTO schema_migrations (version) VALUES ('20140611104959');

INSERT INTO schema_migrations (version) VALUES ('20140611120332');
