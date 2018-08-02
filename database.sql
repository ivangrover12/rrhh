--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.8
-- Dumped by pg_dump version 10.4 (Debian 10.4-2.pgdg90+1)

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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: charges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.charges (
    id bigint NOT NULL,
    name character varying(255),
    base_wage numeric(8,2),
    shortened character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.charges OWNER TO postgres;

--
-- Name: charges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.charges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.charges_id_seq OWNER TO postgres;

--
-- Name: charges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.charges_id_seq OWNED BY public.charges.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    shortened character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_id_seq OWNER TO postgres;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    name character varying(255),
    address character varying(255),
    tax_id_number integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    account_number bigint DEFAULT '10000013809229'::bigint NOT NULL
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: consultancy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consultancy (
    id integer NOT NULL,
    modality_id integer NOT NULL,
    employee_id integer NOT NULL,
    name character varying(255) NOT NULL,
    cite_request character varying(255) NOT NULL,
    date_cite_request character varying(255) NOT NULL,
    authorization_note character varying(255) NOT NULL,
    date_authorization_note character varying(255) NOT NULL,
    certification_budget character varying(255) NOT NULL,
    date_certification_budget character varying(255) NOT NULL,
    year_poa character varying(255) NOT NULL,
    certification_upom character varying(255) NOT NULL,
    date_certification_upom character varying(255) NOT NULL,
    note_award character varying(255) NOT NULL,
    date_note_award character varying(255) NOT NULL,
    report_recommendation character varying(255),
    date_report_recommendation character varying(255),
    object character varying(255) NOT NULL,
    months character varying(255) NOT NULL,
    location character varying(255),
    total_amountr numeric(8,2),
    obligations text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.consultancy OWNER TO postgres;

--
-- Name: consultancy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consultancy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.consultancy_id_seq OWNER TO postgres;

--
-- Name: consultancy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consultancy_id_seq OWNED BY public.consultancy.id;


--
-- Name: contract_job_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract_job_schedule (
    contract_id integer,
    job_schedule_id integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.contract_job_schedule OWNER TO postgres;

--
-- Name: contract_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.contract_types OWNER TO postgres;

--
-- Name: contract_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contract_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contract_types_id_seq OWNER TO postgres;

--
-- Name: contract_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contract_types_id_seq OWNED BY public.contract_types.id;


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contracts (
    id bigint NOT NULL,
    employee_id bigint NOT NULL,
    position_id bigint NOT NULL,
    date_start date,
    date_end date,
    retirement_reason character varying(255),
    status boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    number_insurance character varying(255),
    number_contract character varying(255),
    cite_rrhh character varying(255),
    cite_rrhh_date date,
    numer_announcement character varying(255),
    contracts_type_id bigint,
    consultancy_id bigint,
    cite_performance character varying(255),
    deleted_at timestamp(0) without time zone,
    ovt_contract_mode integer DEFAULT 5 NOT NULL,
    ovt_contract_type integer DEFAULT 1 NOT NULL,
    description text,
    date_retirement date
);


ALTER TABLE public.contracts OWNER TO postgres;

--
-- Name: contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contracts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contracts_id_seq OWNER TO postgres;

--
-- Name: contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contracts_id_seq OWNED BY public.contracts.id;


--
-- Name: employee_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_types (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.employee_types OWNER TO postgres;

--
-- Name: employee_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_types_id_seq OWNER TO postgres;

--
-- Name: employee_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_types_id_seq OWNED BY public.employee_types.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id bigint NOT NULL,
    employee_type_id bigint,
    insurance_company_id bigint,
    city_identity_card_id bigint,
    city_birth_id bigint,
    management_entity_id bigint,
    identity_card character varying(255),
    first_name character varying(255),
    second_name character varying(255),
    last_name character varying(255),
    mothers_last_name character varying(255),
    surname_husband character varying(255),
    birth_date date,
    account_number character varying(255),
    nationality character varying(255),
    nua_cua character varying(255),
    gender character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    location character varying(255),
    zone character varying(255),
    street character varying(255),
    number character varying(255),
    deleted_at timestamp(0) without time zone,
    status boolean DEFAULT true NOT NULL,
    CONSTRAINT employees_gender_check CHECK (((gender)::text = ANY (ARRAY[('M'::character varying)::text, ('F'::character varying)::text])))
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employees_id_seq OWNER TO postgres;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: employer_numbers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employer_numbers (
    id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    number character varying(255) NOT NULL,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.employer_numbers OWNER TO postgres;

--
-- Name: employer_numbers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employer_numbers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employer_numbers_id_seq OWNER TO postgres;

--
-- Name: employer_numbers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employer_numbers_id_seq OWNED BY public.employer_numbers.id;


--
-- Name: insurance_companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.insurance_companies (
    id bigint NOT NULL,
    name character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    ovt_id integer
);


ALTER TABLE public.insurance_companies OWNER TO postgres;

--
-- Name: insurance_companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.insurance_companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.insurance_companies_id_seq OWNER TO postgres;

--
-- Name: insurance_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.insurance_companies_id_seq OWNED BY public.insurance_companies.id;


--
-- Name: job_schedules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_schedules (
    id integer NOT NULL,
    start_hour smallint NOT NULL,
    start_minutes smallint NOT NULL,
    end_hour smallint NOT NULL,
    end_minutes smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.job_schedules OWNER TO postgres;

--
-- Name: job_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_schedules_id_seq OWNER TO postgres;

--
-- Name: job_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_schedules_id_seq OWNED BY public.job_schedules.id;


--
-- Name: management_entities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.management_entities (
    id bigint NOT NULL,
    name character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    ovt_id integer
);


ALTER TABLE public.management_entities OWNER TO postgres;

--
-- Name: management_entities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.management_entities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.management_entities_id_seq OWNER TO postgres;

--
-- Name: management_entities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.management_entities_id_seq OWNED BY public.management_entities.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: months; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.months (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    shortened character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.months OWNER TO postgres;

--
-- Name: months_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.months_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.months_id_seq OWNER TO postgres;

--
-- Name: months_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.months_id_seq OWNED BY public.months.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_resets OWNER TO postgres;

--
-- Name: payrolls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payrolls (
    id bigint NOT NULL,
    contract_id bigint NOT NULL,
    procedure_id bigint NOT NULL,
    name character varying(255),
    date_start character varying(255),
    date_end character varying(255),
    code character varying(255),
    worked_days bigint NOT NULL,
    base_wage numeric(8,2),
    quotable numeric(8,2),
    discount_old numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_common_risk numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_commission numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_solidary numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_national numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    total_amount_discount_law numeric(8,2),
    net_salary numeric(8,2),
    discount_rc_iva numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_faults numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    total_amount_discount_institution numeric(8,2),
    total_discounts numeric(8,2),
    payable_liquid numeric(8,2),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    unworked_days smallint DEFAULT '0'::smallint NOT NULL,
    next_month_balance integer DEFAULT '0'::numeric NOT NULL,
    previous_month_balance integer DEFAULT '0'::numeric NOT NULL
);


ALTER TABLE public.payrolls OWNER TO postgres;

--
-- Name: payrolls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payrolls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payrolls_id_seq OWNER TO postgres;

--
-- Name: payrolls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payrolls_id_seq OWNED BY public.payrolls.id;


--
-- Name: position_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.position_groups (
    id bigint NOT NULL,
    name character varying(255),
    shortened character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    employer_number_id integer
);


ALTER TABLE public.position_groups OWNER TO postgres;

--
-- Name: position_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.position_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.position_groups_id_seq OWNER TO postgres;

--
-- Name: position_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.position_groups_id_seq OWNED BY public.position_groups.id;


--
-- Name: positions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.positions (
    id bigint NOT NULL,
    charge_id bigint,
    position_group_id bigint,
    item character varying(255),
    name character varying(255),
    shortened character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.positions OWNER TO postgres;

--
-- Name: positions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.positions_id_seq OWNER TO postgres;

--
-- Name: positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.positions_id_seq OWNED BY public.positions.id;


--
-- Name: procedures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.procedures (
    id bigint NOT NULL,
    month_id bigint NOT NULL,
    year integer,
    name character varying(255),
    discount_old numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_common_risk numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_commission numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_solidary numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_national numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_rc_iva numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    discount_faults numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    contribution_insurance_company numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    contribution_professional_risk numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    contribution_employer_solidary numeric(8,2) DEFAULT '0'::numeric NOT NULL,
    contribution_employer_housing numeric(8,2) DEFAULT '0'::numeric NOT NULL
);


ALTER TABLE public.procedures OWNER TO postgres;

--
-- Name: procedures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.procedures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.procedures_id_seq OWNER TO postgres;

--
-- Name: procedures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.procedures_id_seq OWNED BY public.procedures.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    username character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: charges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.charges ALTER COLUMN id SET DEFAULT nextval('public.charges_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: consultancy id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultancy ALTER COLUMN id SET DEFAULT nextval('public.consultancy_id_seq'::regclass);


--
-- Name: contract_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_types ALTER COLUMN id SET DEFAULT nextval('public.contract_types_id_seq'::regclass);


--
-- Name: contracts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts ALTER COLUMN id SET DEFAULT nextval('public.contracts_id_seq'::regclass);


--
-- Name: employee_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_types ALTER COLUMN id SET DEFAULT nextval('public.employee_types_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: employer_numbers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employer_numbers ALTER COLUMN id SET DEFAULT nextval('public.employer_numbers_id_seq'::regclass);


--
-- Name: insurance_companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insurance_companies ALTER COLUMN id SET DEFAULT nextval('public.insurance_companies_id_seq'::regclass);


--
-- Name: job_schedules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_schedules ALTER COLUMN id SET DEFAULT nextval('public.job_schedules_id_seq'::regclass);


--
-- Name: management_entities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.management_entities ALTER COLUMN id SET DEFAULT nextval('public.management_entities_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: months id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.months ALTER COLUMN id SET DEFAULT nextval('public.months_id_seq'::regclass);


--
-- Name: payrolls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payrolls ALTER COLUMN id SET DEFAULT nextval('public.payrolls_id_seq'::regclass);


--
-- Name: position_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.position_groups ALTER COLUMN id SET DEFAULT nextval('public.position_groups_id_seq'::regclass);


--
-- Name: positions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions ALTER COLUMN id SET DEFAULT nextval('public.positions_id_seq'::regclass);


--
-- Name: procedures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedures ALTER COLUMN id SET DEFAULT nextval('public.procedures_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: charges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.charges (id, name, base_wage, shortened, created_at, updated_at) FROM stdin;
1	DIRECTOR EJECUTIVO	13200.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
2	DIRECTOR DE AREA	10600.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
3	JEFE DE UNIDAD I	7600.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
4	JEFE DE UNIDAD II	6900.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
5	RESPONSABLE 	6200.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
6	ASESOR	6200.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
7	PROFESIONAL I	5000.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
8	PROFESIONAL II	4500.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
9	PROFESIONAL III	4400.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
10	TECNICO I	3900.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
11	TECNICO II	3500.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
12	ASISTENTE I	3000.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
13	ASISTENTE II	2850.00	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (id, name, shortened, created_at, updated_at) FROM stdin;
1	BENI	BN	2018-05-30 12:59:59	2018-05-30 12:59:59
2	CHUQUISACA	CH	2018-05-30 12:59:59	2018-05-30 12:59:59
3	COCHABAMBA	CB	2018-05-30 12:59:59	2018-05-30 12:59:59
4	LA PAZ	LP	2018-05-30 12:59:59	2018-05-30 12:59:59
5	ORURO	OR	2018-05-30 12:59:59	2018-05-30 12:59:59
6	PANDO	PD	2018-05-30 12:59:59	2018-05-30 12:59:59
7	POTOSÍ	PT	2018-05-30 12:59:59	2018-05-30 12:59:59
8	SANTA CRUZ	SC	2018-05-30 12:59:59	2018-05-30 12:59:59
9	TARIJA	TJ	2018-05-30 12:59:59	2018-05-30 12:59:59
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, address, tax_id_number, created_at, updated_at, account_number) FROM stdin;
1	MUTUAL DE SERVICIOS AL POLICIA	Av. 6 de Agosto No. 2354 - Zona Sopocachi	234578021	2018-07-02 14:57:03	2018-07-02 14:57:03	10000013809229
\.


--
-- Data for Name: consultancy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consultancy (id, modality_id, employee_id, name, cite_request, date_cite_request, authorization_note, date_authorization_note, certification_budget, date_certification_budget, year_poa, certification_upom, date_certification_upom, note_award, date_note_award, report_recommendation, date_report_recommendation, object, months, location, total_amountr, obligations, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: contract_job_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract_job_schedule (contract_id, job_schedule_id, created_at, updated_at) FROM stdin;
33	1	2018-07-06 16:04:40	2018-07-06 16:04:40
33	2	2018-07-06 16:04:40	2018-07-06 16:04:40
69	1	2018-07-06 16:04:40	2018-07-06 16:04:40
69	2	2018-07-06 16:04:40	2018-07-06 16:04:40
9	1	2018-07-06 16:04:40	2018-07-06 16:04:40
9	2	2018-07-06 16:04:40	2018-07-06 16:04:40
1	1	2018-07-06 16:04:40	2018-07-06 16:04:40
1	2	2018-07-06 16:04:40	2018-07-06 16:04:40
44	1	2018-07-06 16:04:40	2018-07-06 16:04:40
44	2	2018-07-06 16:04:40	2018-07-06 16:04:40
57	1	2018-07-06 16:04:40	2018-07-06 16:04:40
57	2	2018-07-06 16:04:40	2018-07-06 16:04:40
10	1	2018-07-06 16:04:40	2018-07-06 16:04:40
10	2	2018-07-06 16:04:40	2018-07-06 16:04:40
2	1	2018-07-06 16:04:40	2018-07-06 16:04:40
2	2	2018-07-06 16:04:40	2018-07-06 16:04:40
4	1	2018-07-06 16:04:40	2018-07-06 16:04:40
4	2	2018-07-06 16:04:40	2018-07-06 16:04:40
6	1	2018-07-06 16:04:40	2018-07-06 16:04:40
6	2	2018-07-06 16:04:40	2018-07-06 16:04:40
7	1	2018-07-06 16:04:40	2018-07-06 16:04:40
7	2	2018-07-06 16:04:40	2018-07-06 16:04:40
12	1	2018-07-06 16:04:40	2018-07-06 16:04:40
12	2	2018-07-06 16:04:40	2018-07-06 16:04:40
13	1	2018-07-06 16:04:40	2018-07-06 16:04:40
13	2	2018-07-06 16:04:40	2018-07-06 16:04:40
8	1	2018-07-06 16:04:40	2018-07-06 16:04:40
8	2	2018-07-06 16:04:40	2018-07-06 16:04:40
14	1	2018-07-06 16:04:40	2018-07-06 16:04:40
14	2	2018-07-06 16:04:40	2018-07-06 16:04:40
15	1	2018-07-06 16:04:40	2018-07-06 16:04:40
15	2	2018-07-06 16:04:40	2018-07-06 16:04:40
18	1	2018-07-06 16:04:40	2018-07-06 16:04:40
18	2	2018-07-06 16:04:40	2018-07-06 16:04:40
19	1	2018-07-06 16:04:40	2018-07-06 16:04:40
19	2	2018-07-06 16:04:40	2018-07-06 16:04:40
21	1	2018-07-06 16:04:40	2018-07-06 16:04:40
21	2	2018-07-06 16:04:40	2018-07-06 16:04:40
24	1	2018-07-06 16:04:40	2018-07-06 16:04:40
24	2	2018-07-06 16:04:40	2018-07-06 16:04:40
27	1	2018-07-06 16:04:40	2018-07-06 16:04:40
27	2	2018-07-06 16:04:40	2018-07-06 16:04:40
29	1	2018-07-06 16:04:40	2018-07-06 16:04:40
29	2	2018-07-06 16:04:40	2018-07-06 16:04:40
36	1	2018-07-06 16:04:40	2018-07-06 16:04:40
36	2	2018-07-06 16:04:40	2018-07-06 16:04:40
37	1	2018-07-06 16:04:40	2018-07-06 16:04:40
37	2	2018-07-06 16:04:40	2018-07-06 16:04:40
39	1	2018-07-06 16:04:40	2018-07-06 16:04:40
39	2	2018-07-06 16:04:40	2018-07-06 16:04:40
40	1	2018-07-06 16:04:40	2018-07-06 16:04:40
40	2	2018-07-06 16:04:40	2018-07-06 16:04:40
42	1	2018-07-06 16:04:40	2018-07-06 16:04:40
42	2	2018-07-06 16:04:40	2018-07-06 16:04:40
43	1	2018-07-06 16:04:40	2018-07-06 16:04:40
43	2	2018-07-06 16:04:40	2018-07-06 16:04:40
45	1	2018-07-06 16:04:40	2018-07-06 16:04:40
45	2	2018-07-06 16:04:40	2018-07-06 16:04:40
46	1	2018-07-06 16:04:40	2018-07-06 16:04:40
46	2	2018-07-06 16:04:40	2018-07-06 16:04:40
47	1	2018-07-06 16:04:40	2018-07-06 16:04:40
47	2	2018-07-06 16:04:40	2018-07-06 16:04:40
49	1	2018-07-06 16:04:40	2018-07-06 16:04:40
49	2	2018-07-06 16:04:40	2018-07-06 16:04:40
50	1	2018-07-06 16:04:40	2018-07-06 16:04:40
50	2	2018-07-06 16:04:40	2018-07-06 16:04:40
52	1	2018-07-06 16:04:40	2018-07-06 16:04:40
52	2	2018-07-06 16:04:40	2018-07-06 16:04:40
53	1	2018-07-06 16:04:40	2018-07-06 16:04:40
53	2	2018-07-06 16:04:40	2018-07-06 16:04:40
58	1	2018-07-06 16:04:40	2018-07-06 16:04:40
58	2	2018-07-06 16:04:40	2018-07-06 16:04:40
59	1	2018-07-06 16:04:40	2018-07-06 16:04:40
59	2	2018-07-06 16:04:40	2018-07-06 16:04:40
60	1	2018-07-06 16:04:40	2018-07-06 16:04:40
60	2	2018-07-06 16:04:40	2018-07-06 16:04:40
64	1	2018-07-06 16:04:40	2018-07-06 16:04:40
64	2	2018-07-06 16:04:40	2018-07-06 16:04:40
66	1	2018-07-06 16:04:40	2018-07-06 16:04:40
66	2	2018-07-06 16:04:40	2018-07-06 16:04:40
70	1	2018-07-06 16:04:40	2018-07-06 16:04:40
70	2	2018-07-06 16:04:40	2018-07-06 16:04:40
71	1	2018-07-06 16:04:40	2018-07-06 16:04:40
71	2	2018-07-06 16:04:40	2018-07-06 16:04:40
31	1	2018-07-06 16:04:40	2018-07-06 16:04:40
31	2	2018-07-06 16:04:40	2018-07-06 16:04:40
62	1	2018-07-06 16:04:40	2018-07-06 16:04:40
62	2	2018-07-06 16:04:40	2018-07-06 16:04:40
63	1	2018-07-06 16:04:40	2018-07-06 16:04:40
63	2	2018-07-06 16:04:40	2018-07-06 16:04:40
72	1	2018-07-06 16:04:40	2018-07-06 16:04:40
72	2	2018-07-06 16:04:40	2018-07-06 16:04:40
73	1	2018-07-06 16:04:40	2018-07-06 16:04:40
73	2	2018-07-06 16:04:40	2018-07-06 16:04:40
74	1	2018-07-06 16:04:40	2018-07-06 16:04:40
74	2	2018-07-06 16:04:40	2018-07-06 16:04:40
75	1	2018-07-06 16:04:40	2018-07-06 16:04:40
75	2	2018-07-06 16:04:40	2018-07-06 16:04:40
76	1	2018-07-06 16:04:40	2018-07-06 16:04:40
76	2	2018-07-06 16:04:40	2018-07-06 16:04:40
77	1	2018-07-06 16:04:40	2018-07-06 16:04:40
77	2	2018-07-06 16:04:40	2018-07-06 16:04:40
78	1	2018-07-06 16:04:40	2018-07-06 16:04:40
78	2	2018-07-06 16:04:40	2018-07-06 16:04:40
79	1	2018-07-06 16:04:40	2018-07-06 16:04:40
79	2	2018-07-06 16:04:40	2018-07-06 16:04:40
80	1	2018-07-06 16:04:40	2018-07-06 16:04:40
80	2	2018-07-06 16:04:40	2018-07-06 16:04:40
81	1	2018-07-06 16:04:40	2018-07-06 16:04:40
81	2	2018-07-06 16:04:40	2018-07-06 16:04:40
82	1	2018-07-06 16:04:40	2018-07-06 16:04:40
82	2	2018-07-06 16:04:40	2018-07-06 16:04:40
83	1	2018-07-06 16:04:40	2018-07-06 16:04:40
83	2	2018-07-06 16:04:40	2018-07-06 16:04:40
88	1	2018-07-06 16:04:40	2018-07-06 16:04:40
88	2	2018-07-06 16:04:40	2018-07-06 16:04:40
87	1	2018-07-06 16:04:40	2018-07-06 16:04:40
87	2	2018-07-06 16:04:40	2018-07-06 16:04:40
89	1	2018-07-06 16:04:40	2018-07-06 16:04:40
89	2	2018-07-06 16:04:40	2018-07-06 16:04:40
90	1	2018-07-06 16:04:40	2018-07-06 16:04:40
90	2	2018-07-06 16:04:40	2018-07-06 16:04:40
91	1	2018-07-06 16:04:40	2018-07-06 16:04:40
91	2	2018-07-06 16:04:40	2018-07-06 16:04:40
92	1	2018-07-06 16:04:40	2018-07-06 16:04:40
92	2	2018-07-06 16:04:40	2018-07-06 16:04:40
98	1	2018-07-06 16:04:40	2018-07-06 16:04:40
98	2	2018-07-06 16:04:40	2018-07-06 16:04:40
99	1	2018-07-06 16:04:40	2018-07-06 16:04:40
99	2	2018-07-06 16:04:40	2018-07-06 16:04:40
100	1	2018-07-06 16:04:40	2018-07-06 16:04:40
100	2	2018-07-06 16:04:40	2018-07-06 16:04:40
101	1	2018-07-06 16:04:40	2018-07-06 16:04:40
101	2	2018-07-06 16:04:40	2018-07-06 16:04:40
102	1	2018-07-06 16:04:40	2018-07-06 16:04:40
102	2	2018-07-06 16:04:40	2018-07-06 16:04:40
103	1	2018-07-06 16:04:40	2018-07-06 16:04:40
103	2	2018-07-06 16:04:40	2018-07-06 16:04:40
105	1	2018-07-06 16:04:40	2018-07-06 16:04:40
105	2	2018-07-06 16:04:40	2018-07-06 16:04:40
106	1	2018-07-06 16:04:40	2018-07-06 16:04:40
106	2	2018-07-06 16:04:40	2018-07-06 16:04:40
107	1	2018-07-06 16:04:40	2018-07-06 16:04:40
107	2	2018-07-06 16:04:40	2018-07-06 16:04:40
108	1	2018-07-06 16:04:40	2018-07-06 16:04:40
108	2	2018-07-06 16:04:40	2018-07-06 16:04:40
111	1	2018-07-06 16:04:40	2018-07-06 16:04:40
111	2	2018-07-06 16:04:40	2018-07-06 16:04:40
112	1	2018-07-06 16:04:40	2018-07-06 16:04:40
112	2	2018-07-06 16:04:40	2018-07-06 16:04:40
20	1	2018-07-06 16:04:40	2018-07-06 16:04:40
20	2	2018-07-06 16:04:40	2018-07-06 16:04:40
113	1	2018-07-06 16:04:40	2018-07-06 16:04:40
113	2	2018-07-06 16:04:40	2018-07-06 16:04:40
114	1	2018-07-06 16:04:40	2018-07-06 16:04:40
114	2	2018-07-06 16:04:40	2018-07-06 16:04:40
115	1	2018-07-06 16:04:40	2018-07-06 16:04:40
115	2	2018-07-06 16:04:40	2018-07-06 16:04:40
116	1	2018-07-06 16:04:40	2018-07-06 16:04:40
116	2	2018-07-06 16:04:40	2018-07-06 16:04:40
117	1	2018-07-06 16:04:40	2018-07-06 16:04:40
117	2	2018-07-06 16:04:40	2018-07-06 16:04:40
119	1	2018-07-06 16:04:40	2018-07-06 16:04:40
119	2	2018-07-06 16:04:40	2018-07-06 16:04:40
120	1	2018-07-06 16:04:40	2018-07-06 16:04:40
120	2	2018-07-06 16:04:40	2018-07-06 16:04:40
121	1	2018-07-06 16:04:40	2018-07-06 16:04:40
121	2	2018-07-06 16:04:40	2018-07-06 16:04:40
122	1	2018-07-06 16:04:40	2018-07-06 16:04:40
122	2	2018-07-06 16:04:40	2018-07-06 16:04:40
123	1	2018-07-06 16:04:40	2018-07-06 16:04:40
123	2	2018-07-06 16:04:40	2018-07-06 16:04:40
124	1	2018-07-06 16:04:40	2018-07-06 16:04:40
124	2	2018-07-06 16:04:40	2018-07-06 16:04:40
127	1	2018-07-06 16:04:40	2018-07-06 16:04:40
127	2	2018-07-06 16:04:40	2018-07-06 16:04:40
128	1	2018-07-06 16:04:40	2018-07-06 16:04:40
128	2	2018-07-06 16:04:40	2018-07-06 16:04:40
110	1	2018-07-06 16:04:40	2018-07-06 16:04:40
110	2	2018-07-06 16:04:40	2018-07-06 16:04:40
129	1	2018-07-06 16:04:40	2018-07-06 16:04:40
129	2	2018-07-06 16:04:40	2018-07-06 16:04:40
130	1	2018-07-06 16:04:40	2018-07-06 16:04:40
130	2	2018-07-06 16:04:40	2018-07-06 16:04:40
131	1	2018-07-06 16:04:40	2018-07-06 16:04:40
131	2	2018-07-06 16:04:40	2018-07-06 16:04:40
132	1	2018-07-06 16:04:40	2018-07-06 16:04:40
132	2	2018-07-06 16:04:40	2018-07-06 16:04:40
133	1	2018-07-06 16:04:40	2018-07-06 16:04:40
133	2	2018-07-06 16:04:40	2018-07-06 16:04:40
134	1	2018-07-06 16:04:40	2018-07-06 16:04:40
134	2	2018-07-06 16:04:40	2018-07-06 16:04:40
135	1	2018-07-06 16:04:40	2018-07-06 16:04:40
135	2	2018-07-06 16:04:40	2018-07-06 16:04:40
68	1	2018-07-06 16:04:40	2018-07-06 16:04:40
68	2	2018-07-06 16:04:40	2018-07-06 16:04:40
136	1	2018-07-06 16:04:40	2018-07-06 16:04:40
136	2	2018-07-06 16:04:40	2018-07-06 16:04:40
137	1	2018-07-06 16:04:40	2018-07-06 16:04:40
137	2	2018-07-06 16:04:40	2018-07-06 16:04:40
139	1	2018-07-06 16:04:40	2018-07-06 16:04:40
139	2	2018-07-06 16:04:40	2018-07-06 16:04:40
140	1	2018-07-06 16:04:40	2018-07-06 16:04:40
140	2	2018-07-06 16:04:40	2018-07-06 16:04:40
141	1	2018-07-06 16:04:40	2018-07-06 16:04:40
141	2	2018-07-06 16:04:40	2018-07-06 16:04:40
142	1	2018-07-06 16:04:40	2018-07-06 16:04:40
142	2	2018-07-06 16:04:40	2018-07-06 16:04:40
143	1	2018-07-06 16:04:40	2018-07-06 16:04:40
143	2	2018-07-06 16:04:40	2018-07-06 16:04:40
144	1	2018-07-06 16:04:40	2018-07-06 16:04:40
144	2	2018-07-06 16:04:40	2018-07-06 16:04:40
145	1	2018-07-06 16:04:40	2018-07-06 16:04:40
145	2	2018-07-06 16:04:40	2018-07-06 16:04:40
146	1	2018-07-06 16:04:40	2018-07-06 16:04:40
146	2	2018-07-06 16:04:40	2018-07-06 16:04:40
147	1	2018-07-06 16:04:40	2018-07-06 16:04:40
147	2	2018-07-06 16:04:40	2018-07-06 16:04:40
148	1	2018-07-06 16:04:40	2018-07-06 16:04:40
148	2	2018-07-06 16:04:40	2018-07-06 16:04:40
149	1	2018-07-06 16:04:40	2018-07-06 16:04:40
149	2	2018-07-06 16:04:40	2018-07-06 16:04:40
150	1	2018-07-06 16:04:40	2018-07-06 16:04:40
150	2	2018-07-06 16:04:40	2018-07-06 16:04:40
151	1	2018-07-06 16:04:40	2018-07-06 16:04:40
151	2	2018-07-06 16:04:40	2018-07-06 16:04:40
152	1	2018-07-06 16:04:40	2018-07-06 16:04:40
152	2	2018-07-06 16:04:40	2018-07-06 16:04:40
153	1	2018-07-06 16:04:40	2018-07-06 16:04:40
153	2	2018-07-06 16:04:40	2018-07-06 16:04:40
154	1	2018-07-06 16:04:40	2018-07-06 16:04:40
154	2	2018-07-06 16:04:40	2018-07-06 16:04:40
155	1	2018-07-06 16:04:40	2018-07-06 16:04:40
155	2	2018-07-06 16:04:40	2018-07-06 16:04:40
51	1	2018-07-23 10:15:51	2018-07-23 10:15:51
51	2	2018-07-23 10:15:51	2018-07-23 10:15:51
16	1	2018-07-23 10:18:32	2018-07-23 10:18:32
16	2	2018-07-23 10:18:32	2018-07-23 10:18:32
5	1	2018-07-23 10:19:06	2018-07-23 10:19:06
5	2	2018-07-23 10:19:06	2018-07-23 10:19:06
56	1	2018-07-23 10:22:10	2018-07-23 10:22:10
56	2	2018-07-23 10:22:10	2018-07-23 10:22:10
54	1	2018-07-23 10:23:46	2018-07-23 10:23:46
54	2	2018-07-23 10:23:46	2018-07-23 10:23:46
34	1	2018-07-26 18:27:27	2018-07-26 18:27:27
34	2	2018-07-26 18:27:27	2018-07-26 18:27:27
161	1	2018-07-26 18:32:26	2018-07-26 18:32:26
161	2	2018-07-26 18:32:26	2018-07-26 18:32:26
23	1	2018-07-26 18:44:14	2018-07-26 18:44:14
23	2	2018-07-26 18:44:14	2018-07-26 18:44:14
162	1	2018-07-26 18:46:23	2018-07-26 18:46:23
162	2	2018-07-26 18:46:23	2018-07-26 18:46:23
35	1	2018-07-26 18:50:03	2018-07-26 18:50:03
35	2	2018-07-26 18:50:03	2018-07-26 18:50:03
163	1	2018-07-26 18:51:51	2018-07-26 18:51:51
163	2	2018-07-26 18:51:51	2018-07-26 18:51:51
126	1	2018-07-27 09:12:43	2018-07-27 09:12:43
126	2	2018-07-27 09:12:43	2018-07-27 09:12:43
164	1	2018-07-27 11:57:16	2018-07-27 11:57:16
164	2	2018-07-27 11:57:16	2018-07-27 11:57:16
67	1	2018-07-27 11:57:36	2018-07-27 11:57:36
67	2	2018-07-27 11:57:36	2018-07-27 11:57:36
86	1	2018-07-27 17:10:53	2018-07-27 17:10:53
86	2	2018-07-27 17:10:53	2018-07-27 17:10:53
26	1	2018-07-27 17:11:34	2018-07-27 17:11:34
26	2	2018-07-27 17:11:34	2018-07-27 17:11:34
28	1	2018-07-27 17:59:14	2018-07-27 17:59:14
28	2	2018-07-27 17:59:14	2018-07-27 17:59:14
166	1	2018-07-30 11:56:25	2018-07-30 11:56:25
166	2	2018-07-30 11:56:25	2018-07-30 11:56:25
167	1	2018-07-30 12:07:40	2018-07-30 12:07:40
167	2	2018-07-30 12:07:40	2018-07-30 12:07:40
168	1	2018-07-30 12:09:19	2018-07-30 12:09:19
168	2	2018-07-30 12:09:19	2018-07-30 12:09:19
170	1	2018-07-30 16:59:19	2018-07-30 16:59:19
170	2	2018-07-30 16:59:19	2018-07-30 16:59:19
55	1	2018-07-30 17:21:41	2018-07-30 17:21:41
55	2	2018-07-30 17:21:41	2018-07-30 17:21:41
41	1	2018-07-30 17:25:30	2018-07-30 17:25:30
41	2	2018-07-30 17:25:30	2018-07-30 17:25:30
65	1	2018-07-30 17:25:55	2018-07-30 17:25:55
65	2	2018-07-30 17:25:55	2018-07-30 17:25:55
32	1	2018-07-30 17:30:23	2018-07-30 17:30:23
32	2	2018-07-30 17:30:23	2018-07-30 17:30:23
85	1	2018-07-30 17:36:44	2018-07-30 17:36:44
85	2	2018-07-30 17:36:44	2018-07-30 17:36:44
171	1	2018-07-30 17:37:56	2018-07-30 17:37:56
171	2	2018-07-30 17:37:56	2018-07-30 17:37:56
84	1	2018-07-30 17:41:31	2018-07-30 17:41:31
84	2	2018-07-30 17:41:31	2018-07-30 17:41:31
138	1	2018-07-31 08:53:56	2018-07-31 08:53:56
138	2	2018-07-31 08:53:56	2018-07-31 08:53:56
109	1	2018-07-31 09:14:44	2018-07-31 09:14:44
109	2	2018-07-31 09:14:44	2018-07-31 09:14:44
157	1	2018-07-31 09:21:18	2018-07-31 09:21:18
157	2	2018-07-31 09:21:18	2018-07-31 09:21:18
38	1	2018-07-31 09:28:52	2018-07-31 09:28:52
38	2	2018-07-31 09:28:52	2018-07-31 09:28:52
172	1	2018-07-31 09:31:25	2018-07-31 09:31:25
172	2	2018-07-31 09:31:25	2018-07-31 09:31:25
25	1	2018-07-31 09:37:35	2018-07-31 09:37:35
25	2	2018-07-31 09:37:35	2018-07-31 09:37:35
165	1	2018-07-31 09:38:25	2018-07-31 09:38:25
165	2	2018-07-31 09:38:25	2018-07-31 09:38:25
173	1	2018-07-31 09:40:16	2018-07-31 09:40:16
173	2	2018-07-31 09:40:16	2018-07-31 09:40:16
174	1	2018-07-31 09:42:25	2018-07-31 09:42:25
174	2	2018-07-31 09:42:25	2018-07-31 09:42:25
30	1	2018-07-31 09:44:42	2018-07-31 09:44:42
30	2	2018-07-31 09:44:42	2018-07-31 09:44:42
125	1	2018-07-31 09:51:42	2018-07-31 09:51:42
125	2	2018-07-31 09:51:42	2018-07-31 09:51:42
48	1	2018-07-31 09:58:47	2018-07-31 09:58:47
48	2	2018-07-31 09:58:47	2018-07-31 09:58:47
3	1	2018-07-31 10:09:48	2018-07-31 10:09:48
3	2	2018-07-31 10:09:48	2018-07-31 10:09:48
175	1	2018-07-31 10:10:30	2018-07-31 10:10:30
175	2	2018-07-31 10:10:30	2018-07-31 10:10:30
11	1	2018-07-31 10:11:42	2018-07-31 10:11:42
11	2	2018-07-31 10:11:42	2018-07-31 10:11:42
17	1	2018-07-31 10:19:40	2018-07-31 10:19:40
17	2	2018-07-31 10:19:40	2018-07-31 10:19:40
169	1	2018-07-31 12:06:22	2018-07-31 12:06:22
169	2	2018-07-31 12:06:22	2018-07-31 12:06:22
22	1	2018-07-31 12:42:53	2018-07-31 12:42:53
22	2	2018-07-31 12:42:53	2018-07-31 12:42:53
61	1	2018-07-31 12:44:21	2018-07-31 12:44:21
61	2	2018-07-31 12:44:21	2018-07-31 12:44:21
\.


--
-- Data for Name: contract_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract_types (id, name, created_at, updated_at, deleted_at) FROM stdin;
1	Libre Nombramiento	2018-07-06 16:01:33	2018-07-06 16:01:33	\N
2	Eventual nuevo	2018-07-06 16:01:33	2018-07-06 16:01:33	\N
3	Eventual recontratacion	2018-07-06 16:01:33	2018-07-06 16:01:33	\N
4	Consultor	2018-07-06 16:01:33	2018-07-06 16:01:33	\N
\.


--
-- Data for Name: contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contracts (id, employee_id, position_id, date_start, date_end, retirement_reason, status, created_at, updated_at, number_insurance, number_contract, cite_rrhh, cite_rrhh_date, numer_announcement, contracts_type_id, consultancy_id, cite_performance, deleted_at, ovt_contract_mode, ovt_contract_type, description, date_retirement) FROM stdin;
9	9	73	2018-01-02	2018-04-02	\N	f	2018-05-30 12:59:59	2018-06-20 10:14:25	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
1	1	63	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:11:46	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
44	43	44	1970-01-01	2018-04-22	\N	f	2018-05-30 12:59:59	2018-06-20 11:26:26	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
57	56	51	2018-01-23	2018-04-22	\N	f	2018-05-30 12:59:59	2018-06-20 11:51:15	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
10	10	26	2018-05-04	2018-12-31	\N	t	2018-05-30 12:59:59	2018-06-20 15:19:39	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
2	2	21	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:13:42	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
4	4	2	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:15:09	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
6	6	45	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:18:09	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
7	7	2	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:20:51	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
12	12	52	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:22:35	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
13	13	68	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:23:46	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
8	8	75	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:24:53	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
14	14	66	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:26:56	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
15	15	62	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:28:16	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
18	18	24	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:30:14	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
19	19	40	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:32:51	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
21	21	2	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:37:48	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
24	24	79	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:39:23	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
27	26	39	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:41:55	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
29	28	28	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:43:19	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
36	35	23	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:45:52	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
37	36	50	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:47:20	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
39	38	8	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:48:23	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
40	39	59	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:51:48	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
42	41	11	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:52:55	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
43	42	37	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 16:14:23	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
45	44	2	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 16:23:15	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
46	45	9	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 16:28:10	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
47	46	71	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 16:47:49	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
49	48	60	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 16:48:56	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
50	49	61	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 16:53:30	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
52	51	69	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:11:47	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
53	52	84	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:13:05	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
58	57	48	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:14:50	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
59	58	2	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:16:16	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
60	59	4	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:17:25	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
64	63	56	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:18:52	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
66	65	20	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:20:34	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
70	69	18	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:25:25	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
71	70	5	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:27:28	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
31	30	41	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:29:31	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
62	61	49	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:35:40	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
63	62	7	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:38:28	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
72	71	89	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:41:09	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
73	72	87	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:42:57	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
74	73	88	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:44:14	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
75	74	85	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:45:30	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
76	75	86	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:47:00	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
77	76	90	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:48:28	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
78	77	91	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:49:46	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
79	78	92	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:50:53	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
80	79	93	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:52:06	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
81	80	94	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:53:07	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
82	81	34	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:55:13	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
83	82	29	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:56:11	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
88	87	33	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:59:06	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
87	86	34	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 18:01:19	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
89	88	43	2018-05-07	2018-08-07	\N	t	2018-06-14 14:26:38	2018-06-14 14:26:38	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
90	89	6	2018-05-07	2018-08-07	\N	t	2018-06-14 14:28:24	2018-06-14 14:28:24	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
91	90	81	2018-05-28	2018-08-26	\N	t	2018-06-14 14:31:32	2018-06-14 14:31:32	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
51	50	20	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-23 10:15:51	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
16	16	65	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-23 10:18:32	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
5	5	58	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-23 10:19:06	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
56	55	9	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-23 10:22:10	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
67	66	82	2018-03-26	2018-06-25	\N	f	2018-05-30 12:59:59	2018-07-27 11:57:36	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
48	47	43	2018-01-02	2018-05-03	\N	f	2018-05-30 12:59:59	2018-07-31 09:58:47	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	El contrato concluia el 02/07/2018	2018-05-03
86	85	31	2018-01-12	2018-07-18	\N	f	2018-05-30 12:59:59	2018-07-27 17:10:53	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
41	40	47	2018-02-14	2018-05-16	\N	f	2018-05-30 12:59:59	2018-07-30 17:25:30	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
55	54	46	2018-01-02	2018-07-02	Retiro	f	2018-05-30 12:59:59	2018-07-30 17:21:41	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	2018-06-12
65	64	20	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-30 17:25:55	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
85	84	30	2018-02-16	2018-05-14	\N	f	2018-05-30 12:59:59	2018-07-30 17:36:44	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
84	83	32	2018-01-12	2018-07-18	\N	f	2018-05-30 12:59:59	2018-07-30 17:41:31	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
38	37	17	2018-03-26	2018-06-25	\N	f	2018-05-30 12:59:59	2018-07-31 09:28:52	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
92	91	12	2018-05-17	2018-08-15	\N	t	2018-06-14 14:35:26	2018-06-14 14:35:26	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
98	47	42	2018-05-04	2018-08-04	\N	t	2018-06-20 11:28:22	2018-06-20 11:28:22	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
99	56	51	2018-04-23	2018-12-31	\N	t	2018-06-20 11:52:19	2018-06-20 11:52:19	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
101	1	63	2018-07-03	2018-12-31	\N	t	2018-07-03 15:13:24	2018-07-03 15:13:24	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
102	2	21	2018-07-03	2018-12-31	\N	t	2018-07-03 15:14:38	2018-07-03 15:14:38	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
103	4	78	2018-07-03	2018-12-31	\N	t	2018-07-03 15:16:41	2018-07-03 15:16:41	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
105	7	54	2018-07-03	2018-12-31	\N	t	2018-07-03 15:22:16	2018-07-03 15:22:16	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
106	12	52	2018-07-03	2018-12-31	\N	t	2018-07-03 15:23:32	2018-07-03 15:23:32	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
107	13	68	2018-07-03	2018-12-31	\N	t	2018-07-03 15:24:34	2018-07-03 15:24:34	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
108	8	75	2018-07-03	2018-12-31	\N	t	2018-07-03 15:26:37	2018-07-03 15:26:37	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
111	18	60	2018-07-03	2018-12-31	\N	t	2018-07-03 15:32:26	2018-07-03 15:32:26	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
112	19	40	2018-07-03	2018-12-31	\N	t	2018-07-03 15:33:51	2018-07-03 15:33:51	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
20	20	13	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 15:34:38	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
113	20	13	2018-07-03	2018-12-31	\N	t	2018-07-03 15:37:32	2018-07-03 15:37:32	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
114	21	36	2018-07-03	2018-12-31	\N	t	2018-07-03 15:39:00	2018-07-03 15:39:00	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
115	24	79	2018-07-03	2018-12-31	\N	t	2018-07-03 15:41:36	2018-07-03 15:41:36	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
116	26	39	2018-07-03	2018-12-31	\N	t	2018-07-03 15:43:02	2018-07-03 15:43:02	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
117	28	28	2018-07-03	2018-12-31	\N	t	2018-07-03 15:44:23	2018-07-03 15:44:23	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
119	36	50	2018-07-03	2018-12-31	\N	t	2018-07-03 15:48:00	2018-07-03 15:48:00	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
120	38	8	2018-07-03	2018-12-31	\N	t	2018-07-03 15:51:27	2018-07-03 15:51:27	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
121	39	59	2018-07-03	2018-12-31	\N	t	2018-07-03 15:52:38	2018-07-03 15:52:38	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
122	41	11	2018-07-03	2018-12-31	\N	t	2018-07-03 15:57:18	2018-07-03 15:57:18	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
123	42	37	2018-07-03	2018-12-31	\N	t	2018-07-03 16:22:47	2018-07-03 16:22:47	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
124	44	16	2018-07-03	2018-12-31	\N	t	2018-07-03 16:27:41	2018-07-03 16:27:41	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
126	46	71	2018-07-03	2018-12-31	\N	t	2018-07-03 16:48:38	2018-07-03 16:48:38	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
127	48	64	2018-07-03	2018-12-31	\N	t	2018-07-03 16:50:37	2018-07-03 16:50:37	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
128	49	61	2018-07-03	2018-12-31	\N	t	2018-07-03 16:54:28	2018-07-03 16:54:28	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
110	15	65	2018-07-03	2018-09-03	\N	t	2018-07-03 15:29:55	2018-07-03 17:11:20	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
129	51	69	2018-07-03	2018-12-31	\N	t	2018-07-03 17:12:43	2018-07-03 17:12:43	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
130	52	84	2018-07-03	2018-10-03	\N	t	2018-07-03 17:14:34	2018-07-03 17:14:34	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
131	57	48	2018-07-03	2018-12-31	\N	t	2018-07-03 17:15:56	2018-07-03 17:15:56	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
132	58	2	2018-07-03	2018-12-31	\N	t	2018-07-03 17:17:06	2018-07-03 17:17:06	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
133	59	4	2018-07-03	2018-12-31	\N	t	2018-07-03 17:18:37	2018-07-03 17:18:37	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
134	63	62	2018-07-03	2018-09-03	\N	t	2018-07-03 17:20:09	2018-07-03 17:20:09	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
135	65	22	2018-07-03	2018-12-31	\N	t	2018-07-03 17:22:40	2018-07-03 17:22:40	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
68	67	3	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-03 17:23:02	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
136	67	3	2018-07-03	2018-12-31	\N	t	2018-07-03 17:23:58	2018-07-03 17:23:58	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
137	69	18	2018-07-03	2018-12-31	\N	t	2018-07-03 17:27:02	2018-07-03 17:27:02	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
139	30	41	2018-07-03	2018-08-03	\N	t	2018-07-03 17:34:42	2018-07-03 17:34:42	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
140	61	49	2018-07-03	2018-09-03	\N	t	2018-07-03 17:37:47	2018-07-03 17:37:47	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
141	62	7	2018-07-03	2018-12-31	\N	t	2018-07-03 17:40:37	2018-07-03 17:40:37	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
142	71	89	2018-07-03	2018-12-31	\N	t	2018-07-03 17:42:33	2018-07-03 17:42:33	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
143	72	87	2018-07-03	2018-12-31	\N	t	2018-07-03 17:43:56	2018-07-03 17:43:56	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
144	73	88	2018-07-03	2018-12-31	\N	t	2018-07-03 17:45:11	2018-07-03 17:45:11	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
145	74	85	2018-07-03	2018-12-31	\N	t	2018-07-03 17:46:28	2018-07-03 17:46:28	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
146	75	86	2018-07-03	2018-12-31	\N	t	2018-07-03 17:48:11	2018-07-03 17:48:11	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
147	76	90	2018-07-03	2018-12-31	\N	t	2018-07-03 17:49:29	2018-07-03 17:49:29	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
148	77	91	2018-07-03	2018-12-31	\N	t	2018-07-03 17:50:35	2018-07-03 17:50:35	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
149	78	92	2018-07-03	2018-12-31	\N	t	2018-07-03 17:51:49	2018-07-03 17:51:49	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
150	79	93	2018-07-03	2018-12-31	\N	t	2018-07-03 17:52:49	2018-07-03 17:52:49	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
151	80	94	2018-07-03	2018-12-31	\N	t	2018-07-03 17:53:55	2018-07-03 17:53:55	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
152	81	34	2018-07-03	2018-12-31	\N	t	2018-07-03 17:55:56	2018-07-03 17:55:56	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
153	82	29	2018-07-03	2018-12-31	\N	t	2018-07-03 17:58:13	2018-07-03 17:58:13	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
154	87	33	2018-07-03	2018-12-31	\N	t	2018-07-03 18:00:56	2018-07-03 18:00:56	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
155	86	34	2018-07-03	2018-12-31	\N	t	2018-07-03 18:02:39	2018-07-03 18:02:39	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
156	93	44	2018-06-01	2018-08-30	\N	t	2018-07-12 16:14:01	2018-07-12 16:14:01	\N	\N	\N	\N	\N	2	\N	\N	\N	5	1	\N	\N
54	53	57	2018-01-02	2018-07-02	\N	f	2018-05-30 12:59:59	2018-07-23 10:23:46	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
69	68	38	2018-03-01	\N	\N	t	2018-05-30 12:59:59	2018-05-30 12:59:59	\N	\N	\N	\N	\N	3	\N	\N	\N	1	2	\N	\N
33	32	53	2018-03-05	\N	\N	t	2018-05-30 12:59:59	2018-05-30 12:59:59	\N	\N	\N	\N	\N	3	\N	\N	\N	1	1	\N	\N
160	45	56	2018-07-18	2018-12-31	\N	t	2018-07-25 18:54:04	2018-07-25 18:54:04	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
23	23	27	2018-03-01	2018-05-30	\N	f	2018-05-30 12:59:59	2018-07-26 18:44:14	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
35	34	83	2018-03-26	2018-06-25	\N	f	2018-05-30 12:59:59	2018-07-26 18:50:03	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
26	25	73	2018-04-23	2018-07-23	\N	f	2018-05-30 12:59:59	2018-07-27 17:11:34	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
28	27	70	2018-04-09	2018-07-08	\N	f	2018-05-30 12:59:59	2018-07-27 17:59:14	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
138	70	5	2018-07-24	2018-12-31	\N	t	2018-07-03 17:29:05	2018-07-31 08:53:56	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
32	31	81	2018-01-02	2018-07-02	Por Renuncia	f	2018-05-30 12:59:59	2018-07-30 17:30:23	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	2018-05-14
157	94	47	2018-06-01	2018-07-10	Renuncia	f	2018-07-12 16:15:01	2018-07-31 09:21:18	\N	\N	\N	\N	\N	2	\N	\N	\N	5	1	El contrato concluía el 30/08/2018	2018-07-10
109	14	66	2018-07-03	2018-12-31	\N	t	2018-07-03 15:28:03	2018-07-31 09:14:44	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
100	92	95	2018-01-15	2018-12-21	\N	t	2018-06-22 15:23:19	2018-06-22 15:23:19	\N	\N	\N	\N	\N	4	\N	\N	\N	5	1	\N	\N
11	11	35	2016-08-01	\N	\N	t	2018-05-30 12:59:59	2018-07-31 10:11:42	\N	\N	\N	\N	\N	1	\N	\N	\N	1	1	\N	\N
17	17	1	2015-09-01	\N	\N	t	2018-05-30 12:59:59	2018-07-31 10:19:40	\N	\N	\N	\N	\N	1	\N	\N	\N	1	1	\N	\N
22	22	77	2018-01-02	2018-05-21	Renuncia	f	2018-05-30 12:59:59	2018-07-31 12:42:53	\N	\N	\N	\N	\N	3	\N	\N	\N	1	1	Tenia contrato indefinido	2018-05-21
158	95	74	2018-06-20	2018-09-19	\N	t	2018-07-12 16:16:11	2018-07-12 16:16:11	\N	\N	\N	\N	\N	2	\N	\N	\N	5	1	\N	\N
159	96	76	2018-06-20	2018-09-19	\N	t	2018-07-12 16:17:04	2018-07-12 16:17:04	\N	\N	\N	\N	\N	2	\N	\N	\N	5	1	\N	\N
34	33	67	2018-04-09	2018-07-08	\N	f	2018-05-30 12:59:59	2018-07-26 18:27:27	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
161	33	67	2018-07-09	2018-12-31	\N	t	2018-07-26 18:32:26	2018-07-26 18:32:26	\N	163	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
162	23	27	2018-06-01	2018-12-31	\N	t	2018-07-26 18:46:23	2018-07-26 18:46:23	\N	102/2018	\N	\N	\N	2	\N	\N	\N	5	1	\N	\N
163	34	83	2018-06-26	2018-12-31	\N	t	2018-07-26 18:51:51	2018-07-26 18:51:51	\N	108/2018	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
166	97	57	2018-07-19	2018-12-31	\N	t	2018-07-30 11:56:25	2018-07-30 11:56:25	\N	\N	RR.HH.-170/2018	\N	\N	2	\N	\N	\N	5	1	\N	\N
167	100	20	2018-07-23	2018-12-31	\N	t	2018-07-30 12:02:33	2018-07-30 12:02:33	\N	\N	RR.HH.-176/2018	\N	\N	2	\N	\N	\N	5	1	\N	\N
168	99	23	2018-07-23	2018-12-31	\N	t	2018-07-30 12:09:19	2018-07-30 12:09:19	\N	\N	RR.HH.-174/2018	\N	\N	2	\N	\N	\N	5	1	\N	\N
170	66	82	2018-06-26	2018-12-31	\N	t	2018-07-30 16:59:19	2018-07-30 16:59:19	\N	107/2018	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
171	84	30	2018-05-15	2018-12-31	\N	t	2018-07-30 17:37:56	2018-07-30 17:37:56	\N	098/2018	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
172	37	17	2018-06-26	2018-12-31	\N	t	2018-07-31 09:31:25	2018-07-31 09:31:25	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
25	25	74	2018-01-02	2018-04-20	Renuncia	f	2018-05-30 12:59:59	2018-07-31 09:37:35	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	El contrato concluía en 02/07/2018	2018-04-20
165	25	73	2018-07-24	2018-12-31	\N	t	2018-07-27 17:12:43	2018-07-31 09:38:25	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
173	27	70	2018-07-09	2018-12-31	\N	t	2018-07-31 09:40:16	2018-07-31 09:40:16	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
174	85	31	2018-07-19	2018-12-31	\N	t	2018-07-31 09:42:25	2018-07-31 09:42:25	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
30	29	76	2018-01-15	2018-05-23	Renuncia	f	2018-05-30 12:59:59	2018-07-31 09:44:42	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	El contrato concluia el 15/07/2018	2018-05-23
125	45	9	2018-07-03	2018-07-17	Por Renuncia	f	2018-07-03 16:39:16	2018-07-31 09:51:42	\N	115/2018	RR.H.- 147/2018	2018-07-03	\N	3	\N	\N	\N	5	1	El contrato concluia el 31/12/2018	2018-07-17
164	47	42	2018-05-04	2018-08-04	\N	t	2018-07-27 11:57:16	2018-07-31 09:56:48	\N	094/2018	\N	\N	\N	3	\N	\N	2018-07-31 09:56:48	5	1	\N	\N
3	3	55	2018-02-01	2018-04-30	\N	f	2018-05-30 12:59:59	2018-07-31 10:09:48	\N	\N	\N	\N	\N	3	\N	\N	\N	5	1	\N	\N
175	3	55	2018-05-02	2018-12-31	\N	t	2018-07-31 10:10:30	2018-07-31 10:10:30	\N	\N	\N	\N	\N	1	\N	\N	\N	5	1	\N	\N
169	98	19	2018-07-23	2018-12-31	\N	t	2018-07-30 12:10:26	2018-07-31 12:06:22	\N	\N	RR.HH.-173/2018	\N	\N	2	\N	\N	\N	5	1	\N	\N
61	60	15	2017-07-13	2018-05-30	Renuncia	f	2018-05-30 12:59:59	2018-07-31 12:44:21	\N	\N	\N	\N	\N	2	\N	\N	\N	1	1	Tenia contrato indefinido	2018-05-30
\.


--
-- Data for Name: employee_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_types (id, name, created_at, updated_at) FROM stdin;
1	Libre Nombramiento	2018-05-30 12:59:59	2018-05-30 12:59:59
2	Eventual	2018-05-30 12:59:59	2018-05-30 12:59:59
3	Consultor	2018-05-30 12:59:59	2018-05-30 12:59:59
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (id, employee_type_id, insurance_company_id, city_identity_card_id, city_birth_id, management_entity_id, identity_card, first_name, second_name, last_name, mothers_last_name, surname_husband, birth_date, account_number, nationality, nua_cua, gender, created_at, updated_at, location, zone, street, number, deleted_at, status) FROM stdin;
52	2	1	4	4	1	4886229	CINTHYA	GABRIELA	QUISBERT	POMA	\N	1983-03-15	10000019404453	\N	43647777	F	2018-05-30 12:59:59	2018-06-13 22:26:08	\N	\N	\N	\N	\N	t
37	2	1	4	4	1	4881022	JORGE	FRANCISCO	MACHACA	CALCINA	\N	1980-11-23	10000024711299	\N	100337430	M	2018-05-30 12:59:59	2018-06-13 21:25:09	\N	\N	\N	\N	\N	t
2	2	1	4	4	1	6096967	JOHNNY	JUNIOR	ALAVE	GUTIERREZ	\N	1984-12-18	10000018696358	\N	44253412	M	2018-05-30 12:59:59	2018-06-13 22:14:37	\N	\N	\N	\N	\N	t
27	2	1	4	4	1	5990351	AIDE	LEONOR	GUTIERREZ	QUISBERT	\N	1979-11-27	10000021574096	\N	40675695	F	2018-05-30 12:59:59	2018-06-13 21:08:01	\N	\N	\N	\N	\N	t
33	2	1	4	4	2	4294797	NELFA	BRIGITTE	LAZARTE	SALINAS	\N	1974-01-08	10000004858821	\N	10628022	F	2018-05-30 12:59:59	2018-06-13 21:09:38	\N	\N	\N	\N	\N	t
36	2	1	4	4	1	9115203	VANESSA	LOURDES	LUNA	CANAVIRI	\N	1992-12-16	10000025978567	\N	47543358	F	2018-05-30 12:59:59	2018-06-13 21:10:39	\N	\N	\N	\N	\N	t
23	2	1	4	4	2	4322190	JUAN	CARLOS	GONZALES	CAHUAYA	\N	1978-02-22	10000027153464	\N	36777778	M	2018-05-30 12:59:59	2018-06-13 21:29:33	\N	\N	\N	\N	\N	t
3	2	1	4	4	2	2449068	FERNANDA	\N	ALEGRIA	ACARAPI	\N	1962-07-07	10000012934655	\N	30485988	F	2018-05-30 12:59:59	2018-06-13 21:30:15	\N	\N	\N	\N	\N	t
40	2	1	6	4	1	6684488	FEDRA	ARLEEN	MARTINEZ	ARANCIBIA	\N	1988-10-05	10000019437305	\N	39986901	F	2018-05-30 12:59:59	2018-06-13 21:32:43	\N	\N	\N	\N	\N	t
13	2	1	4	4	1	6117948	GABRIELA	CAROLINA	CANAZA	CHOQUE	\N	1987-12-11	10000023054517	\N	39692942	F	2018-05-30 12:59:59	2018-06-13 21:33:48	\N	\N	\N	\N	\N	t
48	2	1	4	4	1	3350777	ANA	MARIA	NUÑEZ	SEJAS	\N	1969-02-19	10000017230876	\N	14021067	F	2018-05-30 12:59:59	2018-06-13 21:35:32	\N	\N	\N	\N	\N	t
5	2	1	4	4	1	6866195	DAYNOR	\N	APO	SILLO	\N	1990-10-14	10000026456760	\N	43474883	M	2018-05-30 12:59:59	2018-06-13 21:36:27	\N	\N	\N	\N	\N	t
45	2	1	4	4	1	4837063	HILDA	THANIA	MORALES	PINAYA	\N	1980-12-29	10000016745503	\N	30534872	F	2018-05-30 12:59:59	2018-06-13 21:41:47	\N	\N	\N	\N	\N	t
19	2	1	4	4	2	4836141	CAROLINA	ISABEL	CRUZ	MANCILLA	\N	1978-09-08	10000018607636	\N	32310717	F	2018-05-30 12:59:59	2018-06-13 21:46:25	\N	\N	\N	\N	\N	t
1	2	1	4	4	1	8326080	NELVIS	IRENE	ALARCON	PIZARROSO	\N	1991-06-28	10000009743738	\N	39686681	F	2018-05-30 12:59:59	2018-06-13 22:01:35	\N	\N	\N	\N	\N	t
39	2	1	4	4	2	4904484	SUSANA	EUSEBIA	MAMANI	QUISPE	\N	1983-10-29	10000025202221	\N	41188366	F	2018-05-30 12:59:59	2018-06-13 21:51:52	\N	\N	\N	\N	\N	t
49	2	1	4	4	1	2068484	RAUL	\N	OVANDO	NIETO	\N	1959-09-17	10000010580591	\N	14502252	M	2018-05-30 12:59:59	2018-06-13 21:54:57	\N	\N	\N	\N	\N	t
9	2	1	4	4	2	4756336	BRYAN	FREDDY	BRAÑEZ	TAPIA	\N	1981-06-06	10000017702974	\N	45699860	M	2018-05-30 12:59:59	2018-06-13 21:55:55	\N	\N	\N	\N	\N	t
32	2	1	4	4	2	3367169	FRANZ	\N	LAZO	CHAVEZ	\N	1975-11-12	10000014710102	\N	32783565	M	2018-05-30 12:59:59	2018-06-13 21:56:35	\N	\N	\N	\N	\N	t
50	2	1	4	4	1	4326798	WILMER	EMIGDIO	PAUCARA	RAMOS	\N	1981-11-13	10000017229530	\N	43641453	M	2018-05-30 12:59:59	2018-06-13 21:58:07	\N	\N	\N	\N	\N	t
42	2	1	4	4	1	6161763	GUILLERMO	\N	MEJILLONES	QUISPE	\N	1983-06-08	10000006006361	\N	39737950	M	2018-05-30 12:59:59	2018-06-13 21:58:46	\N	\N	\N	\N	\N	t
38	2	2	4	4	1	4748496	ROLANDO	JESUS	MAGNE	SINGURI	\N	1975-11-10	10000013247049	\N	34823724	M	2018-05-30 12:59:59	2018-06-13 22:00:50	\N	\N	\N	\N	\N	t
22	2	1	4	4	1	2379075	JUAN	MARCOS	GERL	PARDO	\N	1960-08-29	10000004184630	\N	8550396	M	2018-05-30 12:59:59	2018-06-13 22:03:10	\N	\N	\N	\N	\N	t
46	2	1	4	4	1	1061549-1U	JESUS	\N	MORALES	MORENO	\N	1959-07-31	10000005007104	\N	13539981	M	2018-05-30 12:59:59	2018-06-13 22:07:43	\N	\N	\N	\N	\N	t
35	2	1	4	4	2	4887592	PAMELA	LORENA	LOPEZ	TORREZ	\N	1981-04-20	10000009721734	\N	36924325	F	2018-05-30 12:59:59	2018-06-13 22:08:30	\N	\N	\N	\N	\N	t
28	2	1	4	4	2	6800779	JUSTINO	\N	HUAMPO	CALLISAYA	\N	1978-06-01	10000020165234	\N	37287837	M	2018-05-30 12:59:59	2018-06-13 22:11:08	\N	\N	\N	\N	\N	t
21	2	1	4	4	2	4279388	PATRICIA	DORA	FERNANDEZ	CORTEZ	\N	1974-04-14	10000017526605	\N	7598920	F	2018-05-30 12:59:59	2018-06-13 22:11:59	\N	\N	\N	\N	\N	t
41	2	1	4	4	1	487687	MARIA DEL CARMEN	CECILIA	MAZZI	SILVA	\N	1967-04-27	10000006342632	\N	39633172	F	2018-05-30 12:59:59	2018-06-13 22:13:47	\N	\N	\N	\N	\N	t
47	2	1	2	4	2	5695109	KAREN	ANDREA	MURILLO	ROMERO	\N	1988-03-24	10000022964650	\N	41749509	F	2018-05-30 12:59:59	2018-06-13 22:15:24	\N	\N	\N	\N	\N	t
7	2	1	4	4	2	3478970	NANCY	\N	AVILES	MAMANI	\N	1982-03-16	10000024330685	\N	37953308	M	2018-05-30 12:59:59	2018-06-13 22:17:14	\N	\N	\N	\N	\N	t
12	2	1	4	4	1	8358651	JUAN	JOSE	CALLE	CABRERA	\N	1993-05-06	10000021455428	\N	44568307	M	2018-05-30 12:59:59	2018-06-13 22:19:06	\N	\N	\N	\N	\N	t
14	2	1	4	4	1	4265887	MARIA	LUZ	COAQUIRA	TICONA	\N	1974-04-09	10000017220033	\N	43605710	F	2018-05-30 12:59:59	2018-06-13 22:21:12	\N	\N	\N	\N	\N	t
6	2	1	4	4	2	6848816	MARIA	ANTONIETA MIRNA	ALVAREZ	CASTILLO	\N	1990-08-09	10000017766631	\N	41313380	F	2018-05-30 12:59:59	2018-06-13 22:23:10	\N	\N	\N	\N	\N	t
44	2	1	4	4	1	6052573	VERONICA	FELICIDAD	MERCADO	FLORES	\N	1985-03-19	10000017229291	\N	43776760	F	2018-05-30 12:59:59	2018-06-13 22:29:25	\N	\N	\N	\N	\N	t
16	2	1	4	4	1	5948875	ROSARIO	LUISA	CORI	MANCILLA	\N	1981-06-21	10000018381503	\N	35890824	F	2018-05-30 12:59:59	2018-06-13 22:30:34	\N	\N	\N	\N	\N	t
51	2	1	4	4	1	2430451	ALFREDO	AGUSTIN	PEREZ	ALANOCA	\N	1963-08-05	10000024197564	\N	15241661	M	2018-05-30 12:59:59	2018-06-13 22:31:28	\N	\N	\N	\N	\N	t
8	2	1	3	4	1	5907833	FELIX	\N	BALDERRAMA	VEIZAGA	\N	1983-02-03	10000003702657	\N	35781142	M	2018-05-30 12:59:59	2018-06-13 22:32:22	\N	\N	\N	\N	\N	t
25	2	1	4	4	1	4771553	ALEJANDRO	ERICK	GUISBERT	FLOR	\N	1988-12-18	10000020805830	\N	44439027	M	2018-05-30 12:59:59	2018-06-13 22:33:01	\N	\N	\N	\N	\N	t
29	2	1	4	4	1	4875775	MAURICIO	FELIX	IRIARTE	VALENZUELA	\N	1988-08-08	10000026705787	\N	40987036	M	2018-05-30 12:59:59	2018-06-13 22:33:50	\N	\N	\N	\N	\N	t
15	2	1	7	4	2	6629776	JHESSY	JHEOVANA	COCA	CABRERA	\N	1985-10-31	10000009299533	\N	41449149	F	2018-05-30 12:59:59	2018-06-15 12:29:02	\N	\N	\N	\N	\N	t
24	2	1	4	4	2	3342271	JAVIER	SAMUEL	GUERRERO	JORDAN	\N	1972-08-02	10000006021749	\N	32305527	M	2018-05-30 12:59:59	2018-06-13 22:37:22	\N	\N	\N	\N	\N	t
26	2	1	4	4	2	3358454	MARCELO	\N	GUTIERREZ	BUTRON	\N	2017-10-04	10000025296125	\N	36908277	M	2018-05-30 12:59:59	2018-06-13 22:38:11	\N	\N	\N	\N	\N	t
20	2	1	4	4	1	3359403	RAUL	EDUARDO	DURAN	CHOQUE	\N	1971-10-13	10000010647630	\N	39139441	M	2018-05-30 12:59:59	2018-06-14 12:22:57	\N	\N	\N	\N	\N	t
18	2	1	4	4	2	9202221	XIMENA	\N	CRUZ	LAUREL	\N	1989-07-08	10000017547669	\N	45699872	F	2018-05-30 12:59:59	2018-06-15 12:26:44	\N	\N	\N	\N	\N	t
30	2	1	4	4	1	8277418	ANA	GABRIELA	JAUREGUI	AGUILAR	\N	1993-10-10	10000024955649	\N	43363866	F	2018-05-30 12:59:59	2018-06-13 22:12:44	\N	\N	\N	\N	\N	t
88	2	1	4	4	1	6807177	KATHERINE	\N	CHAVEZ	GARFIAS	\N	1991-11-12	10000017714549	\N	\N	F	2018-06-13 20:21:16	2018-06-13 20:21:16	\N	\N	\N	\N	\N	t
34	2	1	4	4	2	4338808	ROCIO	DEL ALBA	JUAREZ	BERRIOS	\N	1976-09-20	10000017181326	\N	31883692	F	2018-05-30 12:59:59	2018-06-13 21:11:29	\N	\N	\N	\N	\N	t
86	2	1	4	4	2	3385877	JUDITH	\N	RAMIREZ	FLORES	\N	1965-09-15	10000018201321	\N	45699859	F	2018-05-30 12:59:59	2018-06-13 21:26:45	\N	\N	\N	\N	\N	t
81	2	1	4	4	1	6091225	MARIA	ISABEL	BARRETO	GUZMAN	\N	1978-04-27	10000024635176	\N	35920713	F	2018-05-30 12:59:59	2018-06-13 21:28:15	\N	\N	\N	\N	\N	t
65	2	1	4	4	1	6083462	TAMY	\N	UGARTE	MALDONADO	\N	1988-11-03	10000025884285	\N	39472450	F	2018-05-30 12:59:59	2018-06-13 21:39:43	\N	\N	\N	\N	\N	t
53	2	1	4	4	1	5954573	MARIA	ELENA	QUISPE	ALANOCA	\N	1980-01-20	10000017220083	\N	33469866	F	2018-05-30 12:59:59	2018-06-13 21:40:54	\N	\N	\N	\N	\N	t
55	2	1	4	4	2	4907550	AMALIA	\N	QUISPE	SIRPA	\N	1981-07-10	10000024254653	\N	37717169	F	2018-05-30 12:59:59	2018-06-13 21:43:52	\N	\N	\N	\N	\N	t
43	2	1	4	4	1	6722699	TATIANA	GABRIELA	MENA	AMARU	\N	1987-03-18	10000026313358	\N	35326785	F	2018-05-30 12:59:59	2018-06-13 21:45:25	\N	\N	\N	\N	\N	t
56	2	1	4	4	2	6987176	MARIELA	MARIA	RAMOS	CORANI	\N	1988-02-21	10000022278019	\N	46155120	F	2018-05-30 12:59:59	2018-06-13 21:49:38	\N	\N	\N	\N	\N	t
63	2	1	4	4	2	4781199	FERNANDO	\N	TICONA	APAZA	\N	1975-12-27	10000009497418	\N	37521652	M	2018-05-30 12:59:59	2018-06-13 21:50:52	\N	\N	\N	\N	\N	t
31	2	1	4	4	1	6835843	RENE	ENRIQUE	JIMENEZ	ORTEGA	\N	1988-01-20	10000009346186	\N	44568101	M	2018-05-30 12:59:59	2018-06-13 21:57:20	\N	\N	\N	\N	\N	t
58	2	1	4	4	1	5960790	MARIA	INES	ROMAN	QUIROGA	\N	1982-01-15	10000017222914	\N	40874205	F	2018-05-30 12:59:59	2018-06-13 22:02:27	\N	\N	\N	\N	\N	t
4	2	1	4	4	1	4268839	CONSUELO	DEL CARMEN	ALIAGA	RIVERO	\N	1974-02-19	10000021210054	\N	34986704	F	2018-05-30 12:59:59	2018-06-13 22:05:22	\N	\N	\N	\N	\N	t
69	2	1	4	4	1	4959444	ELIZABETH	SABINA	VILLCA	JUCHANI	\N	1979-12-30	10000017231816	\N	43887120	F	2018-05-30 12:59:59	2018-06-13 22:06:02	\N	\N	\N	\N	\N	t
67	2	1	4	4	1	2259918	VALENTIN	\N	VALDEZ	MACHACA	\N	1970-01-29	10000017231147	\N	20407361	M	2018-05-30 12:59:59	2018-06-13 22:06:48	\N	\N	\N	\N	\N	t
54	2	1	4	4	1	6076133	GONZALO	\N	QUISPE	FLORES	\N	1988-01-02	10000018294954	\N	43604717	M	2018-05-30 12:59:59	2018-06-13 22:18:13	\N	\N	\N	\N	\N	t
61	2	1	4	4	1	3454752	ERLAND	GASTON	SARAVIA	BELTRAN	\N	1974-08-07	10000012056920	\N	30472118	M	2018-05-30 12:59:59	2018-06-13 22:20:20	\N	\N	\N	\N	\N	t
64	2	1	4	4	2	6833123	DAGMAR	MILENKA	TOVAR	EYZAGUIRRE	\N	1988-07-25	10000025048378	\N	41126543	F	2018-05-30 12:59:59	2018-06-13 22:22:12	\N	\N	\N	\N	\N	t
59	2	1	4	4	1	4851948	OSCAR	HILARION	ROMERO	SILVA	\N	1986-06-15	10000017694113	\N	43661506	M	2018-05-30 12:59:59	2018-06-13 22:24:28	\N	\N	\N	\N	\N	t
66	2	1	4	4	1	6102450	WALDO	\N	VACA	ALVAREZ	\N	1985-08-30	10000026701644	\N	39333127	M	2018-05-30 12:59:59	2018-06-13 22:26:56	\N	\N	\N	\N	\N	t
10	2	1	4	4	1	2286661	IVAN	MARIO	BOLIVAR	PARRAGA	\N	1965-01-19	10000026997011	\N	30537198	M	2018-05-30 12:59:59	2018-06-13 22:27:42	\N	\N	\N	\N	\N	t
82	2	1	4	4	1	8305603	DAYANA	\N	CHAVEZ	BITRON	\N	1989-10-11	10000022144450	\N	40487945	F	2018-05-30 12:59:59	2018-06-13 22:28:36	\N	\N	\N	\N	\N	t
60	2	1	4	4	2	4919607	RONALD	LUIS	SANCHEZ	MOLINA	\N	1980-01-04	10000020808321	\N	37859183	M	2018-05-30 12:59:59	2018-06-13 22:39:07	\N	\N	\N	\N	\N	t
72	2	1	2	4	2	7555331	KAREN	MELISA	MORON	PORCEL	\N	1989-12-06	10000017753109	\N	46844454	F	2018-05-30 12:59:59	2018-06-13 22:40:35	\N	\N	\N	\N	\N	t
74	2	1	8	4	2	2805120	AMPARITO	ELIZABETH	PARADA	MENDEZ	\N	1962-08-26	10000018525771	\N	31541823	F	2018-05-30 12:59:59	2018-06-13 22:41:28	\N	\N	\N	\N	\N	t
73	2	1	3	4	2	5266782	ANA	MARIA	VERDUGUEZ	CLAROS	\N	1979-01-07	10000007768738	\N	42227379	F	2018-05-30 12:59:59	2018-06-13 22:42:38	\N	\N	\N	\N	\N	t
76	2	1	2	4	2	3653169	GREGORIO	\N	BALTAZAR	CONDORI	\N	1980-03-14	10000018431184	\N	37124031	M	2018-05-30 12:59:59	2018-06-13 22:44:03	\N	\N	\N	\N	\N	t
78	2	1	9	4	2	5006621	ROSSIO	\N	APARICIO	ALCOBA	\N	1987-09-01	10000018170146	\N	45747775	F	2018-05-30 12:59:59	2018-06-13 22:45:03	\N	\N	\N	\N	\N	t
85	2	1	4	4	2	8310665	ADRIANA	KAMIL	HARA	VELASCO	\N	1989-09-09	10000026693768	\N	42630149	F	2018-05-30 12:59:59	2018-06-13 22:46:12	\N	\N	\N	\N	\N	t
62	2	1	4	4	1	4885095	CLAUDIA	CRISTAL	TABOADA	ROCHA	\N	1983-02-25	\N	\N	34879316	F	2018-05-30 12:59:59	2018-06-14 12:39:09	\N	\N	\N	\N	\N	t
70	2	1	4	4	1	6759405	PATRICIA	ELIANA	AGUAYO	TORREZ	\N	1986-01-31	10000017231329	\N	44054993	F	2018-05-30 12:59:59	2018-06-14 12:39:50	\N	\N	\N	\N	\N	t
71	2	1	5	4	1	5746099	MARY	\N	SALAZAR	GUERRA	\N	1966-09-15	10000017235545	\N	39655611	F	2018-05-30 12:59:59	2018-06-14 12:40:22	\N	\N	\N	\N	\N	t
75	2	1	8	4	1	8943438	SILVIA	EUGENIA	TORRICO	ARNEZ	\N	1991-03-03	10000017239050	\N	43776841	F	2018-05-30 12:59:59	2018-06-14 13:39:30	\N	\N	\N	\N	\N	t
77	2	1	7	4	1	5500951	ROSMERY	\N	CAIHUARA	VELASQUEZ	\N	1980-04-01	10000018157160	\N	44253801	F	2018-05-30 12:59:59	2018-06-14 13:46:42	\N	\N	\N	\N	\N	t
79	2	1	1	4	1	1727172	MARYSABEL	\N	HURTADO	CORTEZ	\N	1970-07-10	10000006182187	\N	9849609	F	2018-05-30 12:59:59	2018-06-14 13:47:22	\N	\N	\N	\N	\N	t
84	2	1	4	4	1	6814151	DANY	DANIEL	RAMOS	QUENTA	\N	1986-01-07	10000026930459	\N	43025493	M	2018-05-30 12:59:59	2018-06-14 13:48:23	\N	\N	\N	\N	\N	t
87	2	1	4	4	1	8445876	NOELIA	GENESIS	RIOS	BARRERA	\N	1993-02-25	10000017087269	\N	47585031	F	2018-05-30 12:59:59	2018-06-14 13:49:49	\N	\N	\N	\N	\N	t
89	2	1	4	4	2	2292390	GONZALO	\N	GARCIA	GRANDI	\N	1963-01-10	10000009880142	\N	0032275341	M	2018-06-14 14:08:33	2018-06-14 14:08:33	\N	\N	\N	\N	\N	t
90	2	1	4	4	1	6186202	SINDY	AYLA	PONCE	POMA	\N	1984-09-16	10000019889415	\N	40787205	F	2018-06-14 14:12:35	2018-06-14 14:12:35	\N	\N	\N	\N	\N	t
91	2	1	4	4	2	2354570	ELSA	MARIA	SULLAEZ	NINA	\N	1962-06-02	10000004810863	\N	\N	F	2018-06-14 14:17:14	2018-06-14 14:17:14	\N	\N	\N	\N	\N	t
57	2	1	4	4	1	10931325	VANESSA	JACQUELINE	ROCA	TROCHE	\N	1992-09-22	10000018664206	\N	43818018	F	2018-05-30 12:59:59	2018-06-14 14:22:35	\N	\N	\N	\N	\N	t
68	2	1	4	4	1	4905146	MARIA	ROSA	VARGAS	LAIME	\N	1981-09-29	10000004990277	\N	\N	F	2018-05-30 12:59:59	2018-05-30 15:36:22	\N	\N	\N	\N	\N	t
83	2	1	4	4	1	6870739	LUZ	GABRIELA	ESCOBAR	BUSTAMANTE	\N	1988-12-10	10000026695912	\N	049687967	F	2018-05-30 12:59:59	2018-06-13 21:12:43	\N	\N	\N	\N	\N	t
92	3	1	4	4	1	4810992	RUTH	REINA	CORA	LOPEZ	\N	1976-02-16	10000027146691	\N	47211763	F	2018-06-22 15:17:02	2018-06-22 15:17:02	\N	\N	\N	\N	\N	t
93	2	1	4	4	1	5955336	OSCAR	DANIEL	BENITEZ	ESCOBAR	\N	1982-08-04	10000024976629	\N	\N	M	2018-07-12 09:42:25	2018-07-12 09:42:25	\N	\N	\N	\N	\N	t
94	2	1	4	4	1	5979385	CARLOS	ORLANDO	COARITA	FERNANDEZ	\N	1984-03-09	10000020538209	\N	\N	M	2018-07-12 09:49:44	2018-07-12 09:49:44	\N	\N	\N	\N	\N	t
95	2	1	4	4	1	6849202	DANIEL	\N	JIMENEZ	JEREZ	\N	1989-03-21	10000018677150	\N	\N	M	2018-07-12 09:51:58	2018-07-12 09:51:58	\N	\N	\N	\N	\N	t
96	2	1	4	4	2	6031617	WILLIAM	FREDDY	RAMOS	KAPQUIQUE	\N	1987-08-08	10000010919625	\N	\N	M	2018-07-12 09:55:19	2018-07-12 09:55:19	\N	\N	\N	\N	\N	t
80	2	1	6	4	1	1765608	LUCIANA		VEGA	PEREIRA	\N	1981-02-07	10000021220780	\N	\N	F	2018-05-30 12:59:59	2018-05-30 12:59:59	\N	\N	\N	\N	\N	t
98	2	1	4	1	1	7048438	NELMA	XIMENA	DELGADO	FLORES	\N	\N	\N	\N	\N	F	2018-07-30 11:57:51	2018-07-30 11:57:51	\N	\N	\N	\N	\N	t
11	1	1	4	4	2	4285006	GABRIELA	JACKELINE	BUSTILLOS	LANDAETA	\N	1978-03-18	10000012911827	\N	27142711	F	2018-05-30 12:59:59	2018-07-31 10:12:05	\N	\N	\N	\N	\N	t
17	1	1	4	4	2	2616779	JHONNY	DONATO	CORONEL	AYALA	\N	1964-02-04	10000004763814	\N	6277056	M	2018-05-30 12:59:59	2018-07-31 10:19:57	\N	\N	\N	\N	\N	t
100	2	1	4	1	1	4924627	LUZ	ELIANA	LINARES	ARZA	\N	\N	10000019277842	\N	\N	F	2018-07-30 12:00:27	2018-07-31 14:57:41	\N	\N	\N	\N	\N	t
99	2	1	4	1	2	4837024	SONIA	VIRGINIA	CUAQUIRA	LIMACHI	\N	\N	10000014828202	\N	\N	F	2018-07-30 11:59:07	2018-07-31 14:58:12	\N	\N	\N	\N	\N	t
97	2	1	4	1	2	2605770	GELMA	VERONICA	BARREDA	HERRERA	\N	\N	10000023471381	\N	\N	F	2018-07-30 11:53:30	2018-07-31 15:00:01	\N	\N	\N	\N	\N	t
\.


--
-- Data for Name: employer_numbers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employer_numbers (id, created_at, updated_at, number, deleted_at) FROM stdin;
1	2018-07-02 14:56:59	2018-07-02 14:56:59	01-720-0025	\N
2	2018-07-02 14:56:59	2018-07-02 14:56:59	03-720-00010	\N
3	2018-07-02 14:56:59	2018-07-02 14:56:59	09-911-00024	\N
4	2018-07-02 14:56:59	2018-07-02 14:56:59	07-911-00041	\N
5	2018-07-02 14:56:59	2018-07-02 14:56:59	04-720-00004	\N
\.


--
-- Data for Name: insurance_companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.insurance_companies (id, name, created_at, updated_at, ovt_id) FROM stdin;
1	Caja Nacional de Salud (C.N.S.)	2018-05-30 12:59:59	2018-05-30 12:59:59	1
2	Seguro Social Universitario (S.I.S.S.U.B.)	2018-05-30 12:59:59	2018-05-30 12:59:59	7
\.


--
-- Data for Name: job_schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_schedules (id, start_hour, start_minutes, end_hour, end_minutes, created_at, updated_at) FROM stdin;
1	8	0	12	0	2018-07-06 16:04:27	2018-07-06 16:04:27
2	14	30	18	30	2018-07-06 16:04:27	2018-07-06 16:04:27
3	7	0	15	0	2018-07-06 16:04:27	2018-07-06 16:04:27
4	15	0	23	0	2018-07-06 16:04:27	2018-07-06 16:04:27
5	23	0	7	0	2018-07-06 16:04:27	2018-07-06 16:04:27
\.


--
-- Data for Name: management_entities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.management_entities (id, name, created_at, updated_at, ovt_id) FROM stdin;
1	AFP FUTURO	2018-05-30 12:59:59	2018-05-30 12:59:59	2
2	AFP PREVISION	2018-05-30 12:59:59	2018-05-30 12:59:59	1
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2014_10_12_000000_create_users_table	1
2	2014_10_12_100000_create_password_resets_table	1
3	2018_05_11_134329_rrhh_tables	1
8	2018_06_26_183724_create_company_data_table	2
9	2018_06_28_155401_add_employer_contributions	2
10	2018_06_28_163221_create_employer_numbers_table	2
11	2018_06_28_165438_add_relationship_position_groups_employer_number	2
12	2018_06_26_112904_add_to_employees_tables	3
13	2018_06_28_114126_add_to_contracts_table	3
14	2018_07_04_144922_add_account_number_to_companies	3
15	2018_07_05_103146_create_contract_types	4
16	2018_07_05_104230_create_job_schedules_table	4
17	2018_07_05_110419_add_relationship_contract_to_job_schedule	4
18	2018_07_05_110514_create_consultancy	4
19	2018_07_05_113152_add_id_to_contracts_table	4
20	2018_07_05_154257_remove_email_from_users	4
21	2018_07_06_113322_added_soft_delete_to_contract	5
22	2018_07_06_115038_added_soft_delete_to_employee	5
23	2018_07_13_164526_add_status_to_employees_table	6
24	2018_07_18_080229_change_string_to_date_contracts_table	6
25	2018_07_18_114908_add_unworked_days_to_payrolls_table	6
26	2018_07_20_170006_add_next_month_balance_to_payrolls_table	6
27	2018_07_23_161412_add_ovt_ids_to_insurance_companies	6
28	2018_07_23_161831_add_ovt_ids_to_management_entities	6
29	2018_07_23_162130_add_ovt_ids_to_contracts	6
30	2018_07_24_092208_add_previous_month_balance_to_payrolls_table	6
31	2018_07_26_101319_add_description_to_contracts_table	7
32	2018_07_30_100307_add_date_retirement_to_contracts_table	8
33	2018_07_30_183450_change_balance_data_to_payrolls_table	9
\.


--
-- Data for Name: months; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.months (id, name, shortened, created_at, updated_at) FROM stdin;
1	Enero	ENE	2018-05-30 12:59:59	2018-05-30 12:59:59
2	Febrero	FEB	2018-05-30 12:59:59	2018-05-30 12:59:59
3	Marzo	MAR	2018-05-30 12:59:59	2018-05-30 12:59:59
4	Abril	ABR	2018-05-30 12:59:59	2018-05-30 12:59:59
5	Mayo	MAY	2018-05-30 12:59:59	2018-05-30 12:59:59
6	Junio	JUN	2018-05-30 12:59:59	2018-05-30 12:59:59
7	Julio	JUL	2018-05-30 12:59:59	2018-05-30 12:59:59
8	Agosto	AGO	2018-05-30 12:59:59	2018-05-30 12:59:59
9	Septiembre	SEP	2018-05-30 12:59:59	2018-05-30 12:59:59
10	Octubre	OCT	2018-05-30 12:59:59	2018-05-30 12:59:59
11	Noviembre	NOV	2018-05-30 12:59:59	2018-05-30 12:59:59
12	Diciembre	DIC	2018-05-30 12:59:59	2018-05-30 12:59:59
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_resets (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: payrolls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payrolls (id, contract_id, procedure_id, name, date_start, date_end, code, worked_days, base_wage, quotable, discount_old, discount_common_risk, discount_commission, discount_solidary, discount_national, total_amount_discount_law, net_salary, discount_rc_iva, discount_faults, total_amount_discount_institution, total_discounts, payable_liquid, created_at, updated_at, unworked_days, next_month_balance, previous_month_balance) FROM stdin;
5	4	1	Personal Eventual - Mes Abril de 2018	\N	\N	5-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
6	6	1	Personal Eventual - Mes Abril de 2018	\N	\N	6-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	195.00	195.00	690.69	3209.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
7	79	1	Personal Eventual - Mes Abril de 2018	\N	\N	7-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
8	5	1	Personal Eventual - Mes Abril de 2018	\N	\N	8-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	166.67	166.67	802.17	4197.83	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
9	7	1	Personal Eventual - Mes Abril de 2018	\N	\N	9-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
10	8	1	Personal Eventual - Mes Abril de 2018	\N	\N	10-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
11	77	1	Personal Eventual - Mes Abril de 2018	\N	\N	11-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
12	82	1	Personal Eventual - Mes Abril de 2018	\N	\N	12-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
13	10	1	Personal Eventual - Mes Abril de 2018	\N	\N	13-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
14	9	1	Personal Eventual - Mes Abril de 2018	\N	\N	14-18	2	6900.00	460.00	46.00	7.87	2.30	2.30	0.00	58.47	401.53	0.00	0.00	0.00	58.47	401.53	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
15	11	1	Personal Eventual - Mes Abril de 2018	\N	\N	15-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
16	78	1	Personal Eventual - Mes Abril de 2018	\N	\N	16-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
17	12	1	Personal Eventual - Mes Abril de 2018	\N	\N	17-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
18	13	1	Personal Eventual - Mes Abril de 2018	\N	\N	18-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
19	83	1	Personal Eventual - Mes Abril de 2018	\N	\N	19-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
20	14	1	Personal Eventual - Mes Abril de 2018	\N	\N	20-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
21	15	1	Personal Eventual - Mes Abril de 2018	\N	\N	21-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
22	16	1	Personal Eventual - Mes Abril de 2018	\N	\N	22-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
23	17	1	Personal Eventual - Mes Abril de 2018	\N	\N	23-18	30	13200.00	13200.00	1320.00	225.72	66.00	66.00	0.00	1677.72	11522.28	0.00	0.00	0.00	1677.72	11522.28	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
24	19	1	Personal Eventual - Mes Abril de 2018	\N	\N	24-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
25	18	1	Personal Eventual - Mes Abril de 2018	\N	\N	25-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
26	20	1	Personal Eventual - Mes Abril de 2018	\N	\N	26-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
27	84	1	Personal Eventual - Mes Abril de 2018	\N	\N	27-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
28	21	1	Personal Eventual - Mes Abril de 2018	\N	\N	28-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	390.00	390.00	885.69	3014.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
29	22	1	Personal Eventual - Mes Abril de 2018	\N	\N	29-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
30	23	1	Personal Eventual - Mes Abril de 2018	\N	\N	30-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
31	24	1	Personal Eventual - Mes Abril de 2018	\N	\N	31-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	345.00	345.00	1221.99	5678.01	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
32	25	1	Personal Eventual - Mes Abril de 2018	\N	\N	32-18	20	5000.00	3333.33	333.33	57.00	16.67	16.67	0.00	423.67	2909.67	0.00	166.67	166.67	590.34	2743.00	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
33	26	1	Personal Eventual - Mes Abril de 2018	\N	\N	33-18	8	6900.00	1840.00	184.00	31.46	9.20	9.20	0.00	233.86	1606.14	0.00	0.00	0.00	233.86	1606.14	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
34	27	1	Personal Eventual - Mes Abril de 2018	\N	\N	34-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	633.31	633.31	1599.27	6000.73	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
35	28	1	Personal Eventual - Mes Abril de 2018	\N	\N	35-18	22	5000.00	3666.67	366.67	62.70	18.33	18.33	0.00	466.03	3200.63	0.00	83.34	83.34	549.37	3117.29	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
36	86	1	Personal Eventual - Mes Abril de 2018	\N	\N	36-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
37	29	1	Personal Eventual - Mes Abril de 2018	\N	\N	37-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
38	80	1	Personal Eventual - Mes Abril de 2018	\N	\N	38-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
2	1	1	Personal Eventual - Mes Abril de 2018	\N	\N	2-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
3	2	1	Personal Eventual - Mes Abril de 2018	\N	\N	3-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
4	3	1	Personal Eventual - Mes Abril de 2018	\N	\N	4-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	126.50	126.50	1092.46	6507.54	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
43	34	1	Personal Eventual - Mes Abril de 2018	\N	\N	43-18	22	7600.00	5573.33	557.33	95.30	27.87	27.87	0.00	708.37	4864.96	0.00	0.00	0.00	708.37	4864.96	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
44	33	1	Personal Eventual - Mes Abril de 2018	\N	\N	44-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
45	36	1	Personal Eventual - Mes Abril de 2018	\N	\N	45-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
46	37	1	Personal Eventual - Mes Abril de 2018	\N	\N	46-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
47	38	1	Personal Eventual - Mes Abril de 2018	\N	\N	47-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	0.00	0.00	965.96	6634.04	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
48	39	1	Personal Eventual - Mes Abril de 2018	\N	\N	48-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	253.33	253.33	1219.29	6380.71	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
49	40	1	Personal Eventual - Mes Abril de 2018	\N	\N	49-18	30	3500.00	3500.00	350.00	59.85	17.50	17.50	0.00	444.85	3055.15	0.00	58.34	58.34	503.19	2996.81	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
50	41	1	Personal Eventual - Mes Abril de 2018	\N	\N	50-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	83.34	83.34	718.84	4281.16	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
51	42	1	Personal Eventual - Mes Abril de 2018	\N	\N	51-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
52	43	1	Personal Eventual - Mes Abril de 2018	\N	\N	52-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
53	44	1	Personal Eventual - Mes Abril de 2018	\N	\N	53-18	22	5000.00	3666.67	366.67	62.70	18.33	18.33	0.00	466.03	3200.63	0.00	500.01	500.01	966.04	2700.62	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
54	45	1	Personal Eventual - Mes Abril de 2018	\N	\N	54-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
55	46	1	Personal Eventual - Mes Abril de 2018	\N	\N	55-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	250.00	250.00	885.50	4114.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
56	47	1	Personal Eventual - Mes Abril de 2018	\N	\N	56-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
57	73	1	Personal Eventual - Mes Abril de 2018	\N	\N	57-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
58	48	1	Personal Eventual - Mes Abril de 2018	\N	\N	58-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	260.00	260.00	755.69	3144.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
59	49	1	Personal Eventual - Mes Abril de 2018	\N	\N	59-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
60	50	1	Personal Eventual - Mes Abril de 2018	\N	\N	60-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
61	75	1	Personal Eventual - Mes Abril de 2018	\N	\N	61-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
62	51	1	Personal Eventual - Mes Abril de 2018	\N	\N	62-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
63	52	1	Personal Eventual - Mes Abril de 2018	\N	\N	63-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
64	53	1	Personal Eventual - Mes Abril de 2018	\N	\N	64-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	73.34	73.34	632.58	3767.42	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
65	54	1	Personal Eventual - Mes Abril de 2018	\N	\N	65-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	166.67	166.67	802.17	4197.83	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
66	56	1	Personal Eventual - Mes Abril de 2018	\N	\N	66-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	333.33	333.33	968.83	4031.17	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
67	55	1	Personal Eventual - Mes Abril de 2018	\N	\N	67-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	126.66	126.66	1092.62	6507.38	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
68	87	1	Personal Eventual - Mes Abril de 2018	\N	\N	68-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
69	57	1	Personal Eventual - Mes Abril de 2018	\N	\N	69-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
70	85	1	Personal Eventual - Mes Abril de 2018	\N	\N	70-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
71	88	1	Personal Eventual - Mes Abril de 2018	\N	\N	71-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
72	58	1	Personal Eventual - Mes Abril de 2018	\N	\N	72-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
73	59	1	Personal Eventual - Mes Abril de 2018	\N	\N	73-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
74	60	1	Personal Eventual - Mes Abril de 2018	\N	\N	74-18	30	3500.00	3500.00	350.00	59.85	17.50	17.50	0.00	444.85	3055.15	0.00	0.00	0.00	444.85	3055.15	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
75	72	1	Personal Eventual - Mes Abril de 2018	\N	\N	75-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
76	61	1	Personal Eventual - Mes Abril de 2018	\N	\N	76-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
40	31	1	Personal Eventual - Mes Abril de 2018	\N	\N	40-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
41	32	1	Personal Eventual - Mes Abril de 2018	\N	\N	41-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
42	35	1	Personal Eventual - Mes Abril de 2018	\N	\N	42-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
79	64	1	Personal Eventual - Mes Abril de 2018	\N	\N	79-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
80	76	1	Personal Eventual - Mes Abril de 2018	\N	\N	80-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
81	65	1	Personal Eventual - Mes Abril de 2018	\N	\N	81-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
82	66	1	Personal Eventual - Mes Abril de 2018	\N	\N	82-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	260.00	260.00	755.69	3144.31	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
83	67	1	Personal Eventual - Mes Abril de 2018	\N	\N	83-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
84	68	1	Personal Eventual - Mes Abril de 2018	\N	\N	84-18	30	3500.00	3500.00	350.00	59.85	17.50	17.50	0.00	444.85	3055.15	0.00	0.00	0.00	444.85	3055.15	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
85	69	1	Personal Eventual - Mes Abril de 2018	\N	\N	85-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
86	81	1	Personal Eventual - Mes Abril de 2018	\N	\N	86-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
87	74	1	Personal Eventual - Mes Abril de 2018	\N	\N	87-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
88	70	1	Personal Eventual - Mes Abril de 2018	\N	\N	88-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	83.34	83.34	718.84	4281.16	2018-05-30 20:12:26	2018-05-30 21:02:37	0	0	0
1	71	1	Personal Eventual - Mes Abril de 2018	\N	\N	1-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
39	30	1	Personal Eventual - Mes Abril de 2018	\N	\N	39-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-05-30 20:12:25	2018-05-30 21:02:36	0	0	0
77	62	1	Personal Eventual - Mes Abril de 2018	\N	\N	77-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
78	63	1	Personal Eventual - Mes Abril de 2018	\N	\N	78-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	390.00	390.00	885.69	3014.31	2018-05-30 20:12:26	2018-05-30 21:02:36	0	0	0
91	2	2	Personal Eventual - Mes Mayo de 2018	\N	\N	91-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
92	4	2	Personal Eventual - Mes Mayo de 2018	\N	\N	92-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
93	6	2	Personal Eventual - Mes Mayo de 2018	\N	\N	93-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	260.00	260.00	755.69	3144.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
94	79	2	Personal Eventual - Mes Mayo de 2018	\N	\N	94-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
95	5	2	Personal Eventual - Mes Mayo de 2018	\N	\N	95-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
96	7	2	Personal Eventual - Mes Mayo de 2018	\N	\N	96-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
97	8	2	Personal Eventual - Mes Mayo de 2018	\N	\N	97-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
98	77	2	Personal Eventual - Mes Mayo de 2018	\N	\N	98-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
99	82	2	Personal Eventual - Mes Mayo de 2018	\N	\N	99-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
100	11	2	Personal Eventual - Mes Mayo de 2018	\N	\N	100-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
101	78	2	Personal Eventual - Mes Mayo de 2018	\N	\N	101-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
102	12	2	Personal Eventual - Mes Mayo de 2018	\N	\N	102-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
103	13	2	Personal Eventual - Mes Mayo de 2018	\N	\N	103-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	83.33	83.33	718.83	4281.17	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
104	83	2	Personal Eventual - Mes Mayo de 2018	\N	\N	104-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	316.66	316.66	875.90	3524.10	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
105	89	2	Personal Eventual - Mes Mayo de 2018	\N	\N	105-18	25	3900.00	3250.00	325.00	55.58	16.25	16.25	0.00	413.08	2836.93	0.00	65.00	65.00	478.08	2771.93	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
106	14	2	Personal Eventual - Mes Mayo de 2018	\N	\N	106-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
107	15	2	Personal Eventual - Mes Mayo de 2018	\N	\N	107-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
108	16	2	Personal Eventual - Mes Mayo de 2018	\N	\N	108-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
109	17	2	Personal Eventual - Mes Mayo de 2018	\N	\N	109-18	30	13200.00	13200.00	1320.00	225.72	66.00	66.00	0.00	1677.72	11522.28	0.00	0.00	0.00	1677.72	11522.28	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
110	18	2	Personal Eventual - Mes Mayo de 2018	\N	\N	110-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
111	19	2	Personal Eventual - Mes Mayo de 2018	\N	\N	111-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
112	20	2	Personal Eventual - Mes Mayo de 2018	\N	\N	112-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	83.33	83.33	718.83	4281.17	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
90	1	2	Personal Eventual - Mes Mayo de 2018	\N	\N	90-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
115	90	2	Personal Eventual - Mes Mayo de 2018	\N	\N	115-18	25	6200.00	5166.67	516.67	88.35	25.83	25.83	0.00	656.68	4509.98	0.00	0.00	0.00	656.68	4509.98	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
116	22	2	Personal Eventual - Mes Mayo de 2018	\N	\N	116-18	21	10600.00	7420.00	742.00	126.88	37.10	37.10	0.00	943.08	6476.92	0.00	0.00	0.00	943.08	6476.92	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
117	23	2	Personal Eventual - Mes Mayo de 2018	\N	\N	117-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
118	24	2	Personal Eventual - Mes Mayo de 2018	\N	\N	118-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	230.00	230.00	1106.99	5793.01	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
119	26	2	Personal Eventual - Mes Mayo de 2018	\N	\N	119-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
120	27	2	Personal Eventual - Mes Mayo de 2018	\N	\N	120-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	506.67	506.67	1472.63	6127.37	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
121	28	2	Personal Eventual - Mes Mayo de 2018	\N	\N	121-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	333.33	333.33	968.83	4031.17	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
122	86	2	Personal Eventual - Mes Mayo de 2018	\N	\N	122-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
123	29	2	Personal Eventual - Mes Mayo de 2018	\N	\N	123-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
124	80	2	Personal Eventual - Mes Mayo de 2018	\N	\N	124-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
125	30	2	Personal Eventual - Mes Mayo de 2018	\N	\N	125-18	23	5000.00	3833.33	383.33	65.55	19.17	19.17	0.00	487.22	3346.12	0.00	0.00	0.00	487.22	3346.12	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
126	31	2	Personal Eventual - Mes Mayo de 2018	\N	\N	126-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
127	32	2	Personal Eventual - Mes Mayo de 2018	\N	\N	127-18	14	4400.00	2053.33	205.33	35.11	10.27	10.27	0.00	260.98	1792.35	0.00	439.98	439.98	700.96	1352.37	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
128	35	2	Personal Eventual - Mes Mayo de 2018	\N	\N	128-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	83.33	83.33	718.83	4281.17	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
129	34	2	Personal Eventual - Mes Mayo de 2018	\N	\N	129-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	126.67	126.67	1092.63	6507.37	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
130	33	2	Personal Eventual - Mes Mayo de 2018	\N	\N	130-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
131	36	2	Personal Eventual - Mes Mayo de 2018	\N	\N	131-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
132	37	2	Personal Eventual - Mes Mayo de 2018	\N	\N	132-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
133	38	2	Personal Eventual - Mes Mayo de 2018	\N	\N	133-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	0.00	0.00	965.96	6634.04	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
134	39	2	Personal Eventual - Mes Mayo de 2018	\N	\N	134-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	759.99	759.99	1725.95	5874.05	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
135	40	2	Personal Eventual - Mes Mayo de 2018	\N	\N	135-18	30	3500.00	3500.00	350.00	59.85	17.50	17.50	0.00	444.85	3055.15	0.00	174.67	174.67	619.52	2880.48	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
136	41	2	Personal Eventual - Mes Mayo de 2018	\N	\N	136-18	16	5000.00	2666.67	266.67	45.60	13.33	13.33	0.00	338.93	2327.73	0.00	333.20	333.20	672.13	1994.53	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
137	42	2	Personal Eventual - Mes Mayo de 2018	\N	\N	137-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
138	43	2	Personal Eventual - Mes Mayo de 2018	\N	\N	138-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
139	45	2	Personal Eventual - Mes Mayo de 2018	\N	\N	139-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
140	46	2	Personal Eventual - Mes Mayo de 2018	\N	\N	140-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
141	47	2	Personal Eventual - Mes Mayo de 2018	\N	\N	141-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
142	73	2	Personal Eventual - Mes Mayo de 2018	\N	\N	142-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
143	98	2	Personal Eventual - Mes Mayo de 2018	\N	\N	143-18	27	5000.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	333.33	333.33	905.28	3594.72	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
145	49	2	Personal Eventual - Mes Mayo de 2018	\N	\N	145-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
146	50	2	Personal Eventual - Mes Mayo de 2018	\N	\N	146-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
147	75	2	Personal Eventual - Mes Mayo de 2018	\N	\N	147-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
148	51	2	Personal Eventual - Mes Mayo de 2018	\N	\N	148-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
149	52	2	Personal Eventual - Mes Mayo de 2018	\N	\N	149-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
150	91	2	Personal Eventual - Mes Mayo de 2018	\N	\N	150-18	4	4400.00	586.67	58.67	10.03	2.93	2.93	0.00	74.57	512.10	0.00	0.00	0.00	74.57	512.10	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
114	21	2	Personal Eventual - Mes Mayo de 2018	\N	\N	114-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	455.00	455.00	950.69	2949.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
152	56	2	Personal Eventual - Mes Mayo de 2018	\N	\N	152-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	416.63	416.63	1052.13	3947.87	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
158	88	2	Personal Eventual - Mes Mayo de 2018	\N	\N	158-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
159	58	2	Personal Eventual - Mes Mayo de 2018	\N	\N	159-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
160	59	2	Personal Eventual - Mes Mayo de 2018	\N	\N	160-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
161	60	2	Personal Eventual - Mes Mayo de 2018	\N	\N	161-18	30	3500.00	3500.00	350.00	59.85	17.50	17.50	0.00	444.85	3055.15	0.00	0.00	0.00	444.85	3055.15	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
162	72	2	Personal Eventual - Mes Mayo de 2018	\N	\N	162-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
163	61	2	Personal Eventual - Mes Mayo de 2018	\N	\N	163-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
164	62	2	Personal Eventual - Mes Mayo de 2018	\N	\N	164-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
165	92	2	Personal Eventual - Mes Mayo de 2018	\N	\N	165-18	15	6900.00	3450.00	345.00	59.00	17.25	17.25	0.00	438.50	3011.51	0.00	0.00	0.00	438.50	3011.51	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
166	63	2	Personal Eventual - Mes Mayo de 2018	\N	\N	166-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	650.00	650.00	1145.69	2754.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
167	64	2	Personal Eventual - Mes Mayo de 2018	\N	\N	167-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
168	76	2	Personal Eventual - Mes Mayo de 2018	\N	\N	168-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
169	65	2	Personal Eventual - Mes Mayo de 2018	\N	\N	169-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
170	66	2	Personal Eventual - Mes Mayo de 2018	\N	\N	170-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
171	67	2	Personal Eventual - Mes Mayo de 2018	\N	\N	171-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
172	68	2	Personal Eventual - Mes Mayo de 2018	\N	\N	172-18	30	3500.00	3500.00	350.00	59.85	17.50	17.50	0.00	444.85	3055.15	0.00	0.00	0.00	444.85	3055.15	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
173	69	2	Personal Eventual - Mes Mayo de 2018	\N	\N	173-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
174	81	2	Personal Eventual - Mes Mayo de 2018	\N	\N	174-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
175	74	2	Personal Eventual - Mes Mayo de 2018	\N	\N	175-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
176	70	2	Personal Eventual - Mes Mayo de 2018	\N	\N	176-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	83.33	83.33	718.83	4281.17	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
178	10	2	Personal Eventual - Mes Mayo de 2018	\N	\N	13-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-06-20 15:33:51	2018-06-20 15:33:52	0	0	0
157	85	2	Personal Eventual - Mes Mayo de 2018	\N	\N	157-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	\N	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
177	3	2	Personal Eventual - Mes Mayo de 2018	\N	\N	4-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	0.00	0.00	965.96	6634.04	2018-06-20 15:27:26	2018-06-20 15:27:27	0	0	0
179	100	2	Consultor - Mes Mayo de 2018	\N	\N	177-18	30	4400.00	4400.00	0.00	0.00	0.00	0.00	0.00	308.00	4092.00	0.00	308.00	308.00	308.00	4092.00	2018-06-22 15:27:59	2018-06-22 15:28:03	0	0	0
89	71	2	Personal Eventual - Mes Mayo de 2018	\N	\N	89-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	413.32	413.32	1201.34	4998.66	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
113	84	2	Personal Eventual - Mes Mayo de 2018	\N	\N	113-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
144	48	2	Personal Eventual - Mes Mayo de 2018	\N	\N	144-18	3	3900.00	390.00	39.00	6.67	1.95	1.95	0.00	49.57	340.43	0.00	0.00	0.00	49.57	340.43	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
151	53	2	Personal Eventual - Mes Mayo de 2018	\N	\N	151-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	73.33	73.33	632.57	3767.43	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
153	54	2	Personal Eventual - Mes Mayo de 2018	\N	\N	153-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	416.66	416.66	1052.16	3947.84	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
154	55	2	Personal Eventual - Mes Mayo de 2018	\N	\N	154-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	0.00	0.00	965.96	6634.04	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
155	87	2	Personal Eventual - Mes Mayo de 2018	\N	\N	155-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
156	99	2	Personal Eventual - Mes Mayo de 2018	\N	\N	156-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-06-20 12:08:07	2018-06-20 15:13:58	0	0	0
180	138	4	Personal Eventual - Mes Junio de 2018	\N	\N	178-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
181	101	4	Personal Eventual - Mes Junio de 2018	\N	\N	179-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	166.67	166.67	802.17	4197.83	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
182	102	4	Personal Eventual - Mes Junio de 2018	\N	\N	180-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
183	3	4	Personal Eventual - Mes Junio de 2018	\N	\N	181-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	0.00	0.00	965.96	6634.04	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
184	103	4	Personal Eventual - Mes Junio de 2018	\N	\N	182-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
186	149	4	Personal Eventual - Mes Junio de 2018	\N	\N	184-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
187	5	4	Personal Eventual - Mes Junio de 2018	\N	\N	185-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
188	105	4	Personal Eventual - Mes Junio de 2018	\N	\N	186-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
189	108	4	Personal Eventual - Mes Junio de 2018	\N	\N	187-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
190	147	4	Personal Eventual - Mes Junio de 2018	\N	\N	188-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
191	152	4	Personal Eventual - Mes Junio de 2018	\N	\N	189-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
192	156	4	Personal Eventual - Mes Junio de 2018	\N	\N	190-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
193	10	4	Personal Eventual - Mes Junio de 2018	\N	\N	191-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
194	11	4	Personal Eventual - Mes Junio de 2018	\N	\N	192-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
195	148	4	Personal Eventual - Mes Junio de 2018	\N	\N	193-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
196	106	4	Personal Eventual - Mes Junio de 2018	\N	\N	194-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
197	107	4	Personal Eventual - Mes Junio de 2018	\N	\N	195-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
199	153	4	Personal Eventual - Mes Junio de 2018	\N	\N	197-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	366.67	366.67	925.91	3474.09	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
200	109	4	Personal Eventual - Mes Junio de 2018	\N	\N	198-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
201	157	4	Personal Eventual - Mes Junio de 2018	\N	\N	199-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	166.67	166.67	802.17	4197.83	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
202	110	4	Personal Eventual - Mes Junio de 2018	\N	\N	200-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	103.33	103.33	891.35	5308.65	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
204	16	4	Personal Eventual - Mes Junio de 2018	\N	\N	202-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
205	17	4	Personal Eventual - Mes Junio de 2018	\N	\N	203-18	30	13200.00	13200.00	1320.00	225.72	66.00	66.00	0.00	1677.72	11522.28	0.00	0.00	0.00	1677.72	11522.28	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
206	112	4	Personal Eventual - Mes Junio de 2018	\N	\N	204-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
207	111	4	Personal Eventual - Mes Junio de 2018	\N	\N	205-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	195.00	195.00	690.69	3209.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
208	113	4	Personal Eventual - Mes Junio de 2018	\N	\N	206-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	83.33	83.33	718.83	4281.17	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
209	84	4	Personal Eventual - Mes Junio de 2018	\N	\N	207-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
210	114	4	Personal Eventual - Mes Junio de 2018	\N	\N	208-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	455.00	455.00	950.69	2949.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
211	90	4	Personal Eventual - Mes Junio de 2018	\N	\N	209-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	619.98	619.98	1408.00	4792.00	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
214	115	4	Personal Eventual - Mes Junio de 2018	\N	\N	212-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	920.00	920.00	1796.99	5103.01	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
215	26	4	Personal Eventual - Mes Junio de 2018	\N	\N	213-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
216	116	4	Personal Eventual - Mes Junio de 2018	\N	\N	214-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	759.99	759.99	1725.95	5874.05	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
217	28	4	Personal Eventual - Mes Junio de 2018	\N	\N	215-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	83.33	83.33	718.83	4281.17	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
218	86	4	Personal Eventual - Mes Junio de 2018	\N	\N	216-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
219	117	4	Personal Eventual - Mes Junio de 2018	\N	\N	217-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
220	150	4	Personal Eventual - Mes Junio de 2018	\N	\N	218-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
222	139	4	Personal Eventual - Mes Junio de 2018	\N	\N	220-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	130.00	130.00	625.69	3274.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
224	158	4	Personal Eventual - Mes Junio de 2018	\N	\N	222-18	11	5000.00	1833.33	183.33	31.35	9.17	9.17	0.00	233.02	1600.32	0.00	0.00	0.00	233.02	1600.32	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
225	35	4	Personal Eventual - Mes Junio de 2018	\N	\N	223-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	166.67	166.67	802.17	4197.83	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
226	34	4	Personal Eventual - Mes Junio de 2018	\N	\N	224-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	126.67	126.67	1092.63	6507.37	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
213	23	4	Personal Eventual - Mes Junio de 2018	\N	\N	211-18	29	3900.00	3770.00	377.00	64.47	18.85	18.85	0.00	479.17	3290.83	0.00	65.00	65.00	544.17	3225.83	2018-07-12 16:44:57	2018-07-12 16:44:57	1	0	0
227	33	4	Personal Eventual - Mes Junio de 2018	\N	\N	225-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
229	119	4	Personal Eventual - Mes Junio de 2018	\N	\N	227-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	65.00	65.00	560.69	3339.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
230	38	4	Personal Eventual - Mes Junio de 2018	\N	\N	228-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	0.00	0.00	965.96	6634.04	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
231	120	4	Personal Eventual - Mes Junio de 2018	\N	\N	229-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	506.66	506.66	1472.62	6127.38	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
232	121	4	Personal Eventual - Mes Junio de 2018	\N	\N	230-18	30	3500.00	3500.00	350.00	59.85	17.50	17.50	0.00	444.85	3055.15	0.00	0.00	0.00	444.85	3055.15	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
235	123	4	Personal Eventual - Mes Junio de 2018	\N	\N	233-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
236	124	4	Personal Eventual - Mes Junio de 2018	\N	\N	234-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
237	126	4	Personal Eventual - Mes Junio de 2018	\N	\N	235-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
238	125	4	Personal Eventual - Mes Junio de 2018	\N	\N	236-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	333.33	333.33	968.83	4031.17	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
239	143	4	Personal Eventual - Mes Junio de 2018	\N	\N	237-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
241	98	4	Personal Eventual - Mes Junio de 2018	\N	\N	239-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	333.34	333.34	968.84	4031.16	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
242	127	4	Personal Eventual - Mes Junio de 2018	\N	\N	240-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
243	128	4	Personal Eventual - Mes Junio de 2018	\N	\N	241-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
244	145	4	Personal Eventual - Mes Junio de 2018	\N	\N	242-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
245	51	4	Personal Eventual - Mes Junio de 2018	\N	\N	243-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	195.00	195.00	690.69	3209.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
246	129	4	Personal Eventual - Mes Junio de 2018	\N	\N	244-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
247	91	4	Personal Eventual - Mes Junio de 2018	\N	\N	245-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	73.33	73.33	632.57	3767.43	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
248	130	4	Personal Eventual - Mes Junio de 2018	\N	\N	246-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	146.67	146.67	705.91	3694.09	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
249	56	4	Personal Eventual - Mes Junio de 2018	\N	\N	247-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	249.99	249.99	885.49	4114.51	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
250	54	4	Personal Eventual - Mes Junio de 2018	\N	\N	248-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	250.00	250.00	885.50	4114.50	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
251	55	4	Personal Eventual - Mes Junio de 2018	\N	\N	249-18	12	7600.00	3040.00	304.00	51.98	15.20	15.20	0.00	386.38	2653.62	0.00	0.00	0.00	386.38	2653.62	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
252	155	4	Personal Eventual - Mes Junio de 2018	\N	\N	250-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
253	85	4	Personal Eventual - Mes Junio de 2018	\N	\N	251-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
254	159	4	Personal Eventual - Mes Junio de 2018	\N	\N	252-18	11	5000.00	1833.33	183.33	31.35	9.17	9.17	0.00	233.02	1600.32	0.00	0.00	0.00	233.02	1600.32	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
255	99	4	Personal Eventual - Mes Junio de 2018	\N	\N	253-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
256	154	4	Personal Eventual - Mes Junio de 2018	\N	\N	254-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
257	131	4	Personal Eventual - Mes Junio de 2018	\N	\N	255-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
258	132	4	Personal Eventual - Mes Junio de 2018	\N	\N	256-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	260.00	260.00	755.69	3144.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
259	133	4	Personal Eventual - Mes Junio de 2018	\N	\N	257-18	30	3500.00	3500.00	350.00	59.85	17.50	17.50	0.00	444.85	3055.15	0.00	0.00	0.00	444.85	3055.15	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
260	142	4	Personal Eventual - Mes Junio de 2018	\N	\N	258-18	30	3000.00	3000.00	300.00	51.30	15.00	15.00	0.00	381.30	2618.70	0.00	0.00	0.00	381.30	2618.70	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
262	140	4	Personal Eventual - Mes Junio de 2018	\N	\N	260-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
263	92	4	Personal Eventual - Mes Junio de 2018	\N	\N	261-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
264	141	4	Personal Eventual - Mes Junio de 2018	\N	\N	262-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	390.00	390.00	885.69	3014.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
265	134	4	Personal Eventual - Mes Junio de 2018	\N	\N	263-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
266	146	4	Personal Eventual - Mes Junio de 2018	\N	\N	264-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
267	65	4	Personal Eventual - Mes Junio de 2018	\N	\N	265-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
268	135	4	Personal Eventual - Mes Junio de 2018	\N	\N	266-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	195.00	195.00	690.69	3209.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
269	67	4	Personal Eventual - Mes Junio de 2018	\N	\N	267-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
270	136	4	Personal Eventual - Mes Junio de 2018	\N	\N	268-18	30	3500.00	3500.00	350.00	59.85	17.50	17.50	0.00	444.85	3055.15	0.00	0.00	0.00	444.85	3055.15	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
271	69	4	Personal Eventual - Mes Junio de 2018	\N	\N	269-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
272	151	4	Personal Eventual - Mes Junio de 2018	\N	\N	270-18	30	4500.00	4500.00	450.00	76.95	22.50	22.50	0.00	571.95	3928.05	0.00	0.00	0.00	571.95	3928.05	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
273	144	4	Personal Eventual - Mes Junio de 2018	\N	\N	271-18	30	2850.00	2850.00	285.00	48.74	14.25	14.25	0.00	362.24	2487.77	0.00	0.00	0.00	362.24	2487.77	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
274	137	4	Personal Eventual - Mes Junio de 2018	\N	\N	272-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
198	89	4	Personal Eventual - Mes Junio de 2018	\N	\N	196-18	29	3900.00	3770.00	377.00	64.47	18.85	18.85	0.00	479.17	3290.83	0.00	0.00	0.00	479.17	3290.83	2018-07-12 16:44:57	2018-07-12 16:44:57	1	0	0
234	122	4	Personal Eventual - Mes Junio de 2018	\N	\N	232-18	29	6900.00	6670.00	667.00	114.06	33.35	33.35	0.00	847.76	5822.24	0.00	115.00	115.00	962.76	5707.24	2018-07-12 16:44:57	2018-07-12 16:44:57	1	0	0
185	6	4	Personal Eventual - Mes Junio de 2018	\N	\N	183-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	130.00	130.00	625.69	3274.31	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
228	36	4	Personal Eventual - Mes Junio de 2018	\N	\N	226-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-07-12 16:44:57	2018-07-12 16:44:57	0	0	0
277	1	3	Personal Eventual - Mes Julio de 2018	\N	\N	274-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
278	101	3	Personal Eventual - Mes Julio de 2018	\N	\N	274-18	28	5000.00	4666.67	466.67	79.80	23.33	23.33	0.00	593.13	4073.53	0.00	166.66	166.66	759.79	3906.87	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
275	71	3	Personal Eventual - Mes Julio de 2018	\N	\N	273-18	2	6200.00	413.33	41.33	7.07	2.07	2.07	0.00	52.53	360.80	0.00	0.00	0.00	52.53	360.80	2018-07-31 12:24:42	2018-07-31 13:13:09	0	0	0
281	175	3	Personal Eventual - Mes Julio de 2018	\N	\N	276-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	0.00	0.00	965.96	6634.04	2018-07-31 12:24:42	2018-07-31 13:13:09	0	0	0
282	4	3	Personal Eventual - Mes Julio de 2018	\N	\N	277-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:42	2018-07-31 13:13:09	0	0	0
283	103	3	Personal Eventual - Mes Julio de 2018	\N	\N	277-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	0.00	0.00	462.64	3177.36	2018-07-31 12:24:42	2018-07-31 13:13:09	0	0	0
284	6	3	Personal Eventual - Mes Julio de 2018	\N	\N	278-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
285	79	3	Personal Eventual - Mes Julio de 2018	\N	\N	279-18	2	4500.00	300.00	30.00	5.13	1.50	1.50	0.00	38.13	261.87	0.00	0.00	0.00	38.13	261.87	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
286	149	3	Personal Eventual - Mes Julio de 2018	\N	\N	279-18	28	4500.00	4200.00	420.00	71.82	21.00	21.00	0.00	533.82	3666.18	0.00	0.00	0.00	533.82	3666.18	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
287	5	3	Personal Eventual - Mes Julio de 2018	\N	\N	280-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
288	7	3	Personal Eventual - Mes Julio de 2018	\N	\N	281-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
289	105	3	Personal Eventual - Mes Julio de 2018	\N	\N	281-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	0.00	0.00	462.64	3177.36	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
290	8	3	Personal Eventual - Mes Julio de 2018	\N	\N	282-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
291	108	3	Personal Eventual - Mes Julio de 2018	\N	\N	282-18	28	5000.00	4666.67	466.67	79.80	23.33	23.33	0.00	593.13	4073.53	0.00	0.00	0.00	593.13	4073.53	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
280	102	3	Personal Eventual - Mes Julio de 2018	\N	\N	275-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	130.00	130.00	592.64	3047.36	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
307	153	3	Personal Eventual - Mes Julio de 2018	\N	\N	292-18	28	4400.00	4106.67	410.67	70.22	20.53	20.53	0.00	521.96	3584.71	0.00	293.33	293.33	815.29	3291.38	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
325	21	3	Personal Eventual - Mes Julio de 2018	\N	\N	307-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
326	114	3	Personal Eventual - Mes Julio de 2018	\N	\N	307-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	195.00	195.00	657.64	2982.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
318	111	3	Personal Eventual - Mes Julio de 2018	\N	\N	302-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	130.00	130.00	592.64	3047.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
327	90	3	Personal Eventual - Mes Julio de 2018	\N	\N	308-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	103.33	103.33	891.35	5308.65	2018-07-31 12:24:43	2018-07-31 13:24:16	0	0	0
292	77	3	Personal Eventual - Mes Julio de 2018	\N	\N	283-18	2	3000.00	200.00	20.00	3.42	1.00	1.00	0.00	25.42	174.58	0.00	0.00	0.00	25.42	174.58	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
293	147	3	Personal Eventual - Mes Julio de 2018	\N	\N	283-18	28	3000.00	2800.00	280.00	47.88	14.00	14.00	0.00	355.88	2444.12	0.00	0.00	0.00	355.88	2444.12	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
294	166	3	Personal Eventual - Mes Julio de 2018	\N	\N	284-18	12	5000.00	2000.00	200.00	34.20	10.00	10.00	0.00	254.20	1745.80	0.00	0.00	0.00	254.20	1745.80	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
295	82	3	Personal Eventual - Mes Julio de 2018	\N	\N	285-18	2	2850.00	190.00	19.00	3.25	0.95	0.95	0.00	24.15	165.85	0.00	0.00	0.00	24.15	165.85	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
296	152	3	Personal Eventual - Mes Julio de 2018	\N	\N	285-18	28	2850.00	2660.00	266.00	45.49	13.30	13.30	0.00	338.09	2321.91	0.00	0.00	0.00	338.09	2321.91	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
298	10	3	Personal Eventual - Mes Julio de 2018	\N	\N	287-18	30	6200.00	6200.00	620.00	106.02	31.00	31.00	0.00	788.02	5411.98	0.00	0.00	0.00	788.02	5411.98	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
299	11	3	Personal Eventual - Mes Julio de 2018	\N	\N	288-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
300	78	3	Personal Eventual - Mes Julio de 2018	\N	\N	289-18	2	3000.00	200.00	20.00	3.42	1.00	1.00	0.00	25.42	174.58	0.00	0.00	0.00	25.42	174.58	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
301	148	3	Personal Eventual - Mes Julio de 2018	\N	\N	289-18	28	3000.00	2800.00	280.00	47.88	14.00	14.00	0.00	355.88	2444.12	0.00	0.00	0.00	355.88	2444.12	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
302	12	3	Personal Eventual - Mes Julio de 2018	\N	\N	290-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
303	106	3	Personal Eventual - Mes Julio de 2018	\N	\N	290-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	0.00	0.00	462.64	3177.36	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
304	13	3	Personal Eventual - Mes Julio de 2018	\N	\N	291-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
305	107	3	Personal Eventual - Mes Julio de 2018	\N	\N	291-18	28	5000.00	4666.67	466.67	79.80	23.33	23.33	0.00	593.13	4073.53	0.00	0.00	0.00	593.13	4073.53	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
308	89	3	Personal Eventual - Mes Julio de 2018	\N	\N	293-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
309	14	3	Personal Eventual - Mes Julio de 2018	\N	\N	294-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
310	109	3	Personal Eventual - Mes Julio de 2018	\N	\N	294-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	0.00	0.00	462.64	3177.36	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
311	168	3	Personal Eventual - Mes Julio de 2018	\N	\N	295-18	8	6200.00	1653.33	165.33	28.27	8.27	8.27	0.00	210.14	1443.19	0.00	0.00	0.00	210.14	1443.19	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
312	157	3	Personal Eventual - Mes Julio de 2018	\N	\N	296-18	10	5000.00	1666.67	166.67	28.50	8.33	8.33	0.00	211.83	1454.83	0.00	0.00	0.00	211.83	1454.83	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
313	15	3	Personal Eventual - Mes Julio de 2018	\N	\N	297-18	2	6200.00	413.33	41.33	7.07	2.07	2.07	0.00	52.53	360.80	0.00	0.00	0.00	52.53	360.80	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
314	110	3	Personal Eventual - Mes Julio de 2018	\N	\N	298-18	28	6200.00	5786.67	578.67	98.95	28.93	28.93	0.00	735.49	5051.18	0.00	0.00	0.00	735.49	5051.18	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
315	16	3	Personal Eventual - Mes Julio de 2018	\N	\N	299-18	2	6200.00	413.33	41.33	7.07	2.07	2.07	0.00	52.53	360.80	0.00	0.00	0.00	52.53	360.80	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
316	17	3	Personal Eventual - Mes Julio de 2018	\N	\N	300-18	30	13200.00	13200.00	1320.00	225.72	66.00	66.00	0.00	1677.72	11522.28	0.00	0.00	0.00	1677.72	11522.28	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
319	19	3	Personal Eventual - Mes Julio de 2018	\N	\N	303-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
320	112	3	Personal Eventual - Mes Julio de 2018	\N	\N	303-18	28	5000.00	4666.67	466.67	79.80	23.33	23.33	0.00	593.13	4073.53	0.00	0.00	0.00	593.13	4073.53	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
321	169	3	Personal Eventual - Mes Julio de 2018	\N	\N	304-18	8	3900.00	1040.00	104.00	17.78	5.20	5.20	0.00	132.18	907.82	0.00	0.00	0.00	132.18	907.82	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
322	20	3	Personal Eventual - Mes Julio de 2018	\N	\N	305-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
323	113	3	Personal Eventual - Mes Julio de 2018	\N	\N	305-18	28	5000.00	4666.67	466.67	79.80	23.33	23.33	0.00	593.13	4073.53	0.00	0.00	0.00	593.13	4073.53	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
324	84	3	Personal Eventual - Mes Julio de 2018	\N	\N	306-18	18	2850.00	1710.00	171.00	29.24	8.55	8.55	0.00	217.34	1492.66	0.00	0.00	0.00	217.34	1492.66	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
306	83	3	Personal Eventual - Mes Julio de 2018	\N	\N	292-18	2	4400.00	293.33	29.33	5.02	1.47	1.47	0.00	37.28	256.05	0.00	0.00	0.00	37.28	256.05	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
355	172	3	Personal Eventual - Mes Julio de 2018	\N	\N	326-18	30	7600.00	7600.00	760.00	129.96	38.00	38.00	0.00	965.96	6634.04	0.00	379.99	379.99	1345.95	6254.05	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
336	28	3	Personal Eventual - Mes Julio de 2018	\N	\N	314-18	8	5000.00	1333.33	133.33	22.80	6.67	6.67	0.00	169.47	1163.87	0.00	0.00	0.00	169.47	1163.87	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
337	173	3	Personal Eventual - Mes Julio de 2018	\N	\N	314-18	22	5000.00	3666.67	366.67	62.70	18.33	18.33	0.00	466.03	3200.63	0.00	333.32	333.32	799.35	2867.31	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
334	27	3	Personal Eventual - Mes Julio de 2018	\N	\N	313-18	2	7600.00	506.67	50.67	8.66	2.53	2.53	0.00	64.40	442.27	0.00	0.00	0.00	64.40	442.27	2018-07-31 12:24:43	2018-07-31 13:25:51	0	0	0
350	33	3	Personal Eventual - Mes Julio de 2018	\N	\N	322-18	30	10600.00	10600.00	1060.00	181.26	53.00	53.00	0.00	1347.26	9252.74	0.00	0.00	0.00	1347.26	9252.74	2018-07-31 12:24:43	2018-07-31 14:42:25	0	322	484
329	162	3	Personal Eventual - Mes Julio de 2018	\N	\N	310-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
330	24	3	Personal Eventual - Mes Julio de 2018	\N	\N	311-18	2	6900.00	460.00	46.00	7.87	2.30	2.30	0.00	58.47	401.53	0.00	0.00	0.00	58.47	401.53	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
331	115	3	Personal Eventual - Mes Julio de 2018	\N	\N	311-18	28	6900.00	6440.00	644.00	110.12	32.20	32.20	0.00	818.52	5621.48	0.00	805.00	805.00	1623.52	4816.48	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
332	26	3	Personal Eventual - Mes Julio de 2018	\N	\N	312-18	23	6900.00	5290.00	529.00	90.46	26.45	26.45	0.00	672.36	4617.64	0.00	0.00	0.00	672.36	4617.64	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
333	165	3	Personal Eventual - Mes Julio de 2018	\N	\N	312-18	7	6900.00	1610.00	161.00	27.53	8.05	8.05	0.00	204.63	1405.37	0.00	0.00	0.00	204.63	1405.37	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
335	116	3	Personal Eventual - Mes Julio de 2018	\N	\N	313-18	28	7600.00	7093.33	709.33	121.30	35.47	35.47	0.00	901.56	6191.77	0.00	506.66	506.66	1408.22	5685.11	2018-07-31 12:24:43	2018-07-31 13:25:51	0	0	0
338	86	3	Personal Eventual - Mes Julio de 2018	\N	\N	315-18	18	3900.00	2340.00	234.00	40.01	11.70	11.70	0.00	297.41	2042.59	0.00	0.00	0.00	297.41	2042.59	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
339	174	3	Personal Eventual - Mes Julio de 2018	\N	\N	315-18	12	3900.00	1560.00	156.00	26.68	7.80	7.80	0.00	198.28	1361.72	0.00	0.00	0.00	198.28	1361.72	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
340	29	3	Personal Eventual - Mes Julio de 2018	\N	\N	316-18	2	3000.00	200.00	20.00	3.42	1.00	1.00	0.00	25.42	174.58	0.00	0.00	0.00	25.42	174.58	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
341	117	3	Personal Eventual - Mes Julio de 2018	\N	\N	316-18	28	3000.00	2800.00	280.00	47.88	14.00	14.00	0.00	355.88	2444.12	0.00	0.00	0.00	355.88	2444.12	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
342	80	3	Personal Eventual - Mes Julio de 2018	\N	\N	317-18	2	4500.00	300.00	30.00	5.13	1.50	1.50	0.00	38.13	261.87	0.00	0.00	0.00	38.13	261.87	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
343	150	3	Personal Eventual - Mes Julio de 2018	\N	\N	317-18	28	4500.00	4200.00	420.00	71.82	21.00	21.00	0.00	533.82	3666.18	0.00	0.00	0.00	533.82	3666.18	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
347	163	3	Personal Eventual - Mes Julio de 2018	\N	\N	320-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	166.66	166.66	802.16	4197.84	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
348	34	3	Personal Eventual - Mes Julio de 2018	\N	\N	321-18	8	7600.00	2026.67	202.67	34.66	10.13	10.13	0.00	257.59	1769.08	0.00	0.00	0.00	257.59	1769.08	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
349	161	3	Personal Eventual - Mes Julio de 2018	\N	\N	321-18	22	7600.00	5573.33	557.33	95.30	27.87	27.87	0.00	708.37	4864.96	0.00	0.00	0.00	708.37	4864.96	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
351	167	3	Personal Eventual - Mes Julio de 2018	\N	\N	323-18	8	3900.00	1040.00	104.00	17.78	5.20	5.20	0.00	132.18	907.82	0.00	0.00	0.00	132.18	907.82	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
352	36	3	Personal Eventual - Mes Julio de 2018	\N	\N	324-18	2	6200.00	413.33	41.33	7.07	2.07	2.07	0.00	52.53	360.80	0.00	0.00	0.00	52.53	360.80	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
353	37	3	Personal Eventual - Mes Julio de 2018	\N	\N	325-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
354	119	3	Personal Eventual - Mes Julio de 2018	\N	\N	325-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	0.00	0.00	462.64	3177.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
356	39	3	Personal Eventual - Mes Julio de 2018	\N	\N	327-18	2	7600.00	506.67	50.67	8.66	2.53	2.53	0.00	64.40	442.27	0.00	0.00	0.00	64.40	442.27	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
357	120	3	Personal Eventual - Mes Julio de 2018	\N	\N	327-18	28	7600.00	7093.33	709.33	121.30	35.47	35.47	0.00	901.56	6191.77	0.00	0.00	0.00	901.56	6191.77	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
358	40	3	Personal Eventual - Mes Julio de 2018	\N	\N	328-18	2	3500.00	233.33	23.33	3.99	1.17	1.17	0.00	29.66	203.68	0.00	0.00	0.00	29.66	203.68	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
359	121	3	Personal Eventual - Mes Julio de 2018	\N	\N	328-18	28	3500.00	3266.67	326.67	55.86	16.33	16.33	0.00	415.19	2851.47	0.00	0.00	0.00	415.19	2851.47	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
360	42	3	Personal Eventual - Mes Julio de 2018	\N	\N	329-18	2	6900.00	460.00	46.00	7.87	2.30	2.30	0.00	58.47	401.53	0.00	0.00	0.00	58.47	401.53	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
361	122	3	Personal Eventual - Mes Julio de 2018	\N	\N	329-18	28	6900.00	6440.00	644.00	110.12	32.20	32.20	0.00	818.52	5621.48	0.00	0.00	0.00	818.52	5621.48	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
362	43	3	Personal Eventual - Mes Julio de 2018	\N	\N	330-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
363	123	3	Personal Eventual - Mes Julio de 2018	\N	\N	330-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	0.00	0.00	462.64	3177.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
345	139	3	Personal Eventual - Mes Julio de 2018	\N	\N	318-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	65.00	65.00	527.64	3112.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
398	132	3	Personal Eventual - Mes Julio de 2018	\N	\N	353-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	65.00	65.00	527.64	3112.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
383	91	3	Personal Eventual - Mes Julio de 2018	\N	\N	343-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	73.32	73.32	632.56	3767.44	2018-07-31 12:24:43	2018-07-31 15:14:13	0	0	0
364	45	3	Personal Eventual - Mes Julio de 2018	\N	\N	331-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
365	124	3	Personal Eventual - Mes Julio de 2018	\N	\N	331-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	0.00	0.00	462.64	3177.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
366	46	3	Personal Eventual - Mes Julio de 2018	\N	\N	332-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
367	125	3	Personal Eventual - Mes Julio de 2018	\N	\N	332-18	15	5000.00	2500.00	250.00	42.75	12.50	12.50	0.00	317.75	2182.25	0.00	0.00	0.00	317.75	2182.25	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
368	160	3	Personal Eventual - Mes Julio de 2018	\N	\N	333-18	13	6200.00	2686.67	268.67	45.94	13.43	13.43	0.00	341.48	2345.19	0.00	0.00	0.00	341.48	2345.19	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
369	47	3	Personal Eventual - Mes Julio de 2018	\N	\N	334-18	2	6900.00	460.00	46.00	7.87	2.30	2.30	0.00	58.47	401.53	0.00	0.00	0.00	58.47	401.53	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
370	126	3	Personal Eventual - Mes Julio de 2018	\N	\N	334-18	28	6900.00	6440.00	644.00	110.12	32.20	32.20	0.00	818.52	5621.48	0.00	0.00	0.00	818.52	5621.48	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
371	73	3	Personal Eventual - Mes Julio de 2018	\N	\N	335-18	2	4500.00	300.00	30.00	5.13	1.50	1.50	0.00	38.13	261.87	0.00	0.00	0.00	38.13	261.87	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
372	143	3	Personal Eventual - Mes Julio de 2018	\N	\N	335-18	28	4500.00	4200.00	420.00	71.82	21.00	21.00	0.00	533.82	3666.18	0.00	0.00	0.00	533.82	3666.18	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
374	49	3	Personal Eventual - Mes Julio de 2018	\N	\N	337-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
375	127	3	Personal Eventual - Mes Julio de 2018	\N	\N	338-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	0.00	0.00	462.64	3177.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
376	50	3	Personal Eventual - Mes Julio de 2018	\N	\N	339-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
377	128	3	Personal Eventual - Mes Julio de 2018	\N	\N	339-18	28	5000.00	4666.67	466.67	79.80	23.33	23.33	0.00	593.13	4073.53	0.00	0.00	0.00	593.13	4073.53	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
378	75	3	Personal Eventual - Mes Julio de 2018	\N	\N	340-18	2	4500.00	300.00	30.00	5.13	1.50	1.50	0.00	38.13	261.87	0.00	0.00	0.00	38.13	261.87	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
379	145	3	Personal Eventual - Mes Julio de 2018	\N	\N	340-18	28	4500.00	4200.00	420.00	71.82	21.00	21.00	0.00	533.82	3666.18	0.00	0.00	0.00	533.82	3666.18	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
380	51	3	Personal Eventual - Mes Julio de 2018	\N	\N	341-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
381	52	3	Personal Eventual - Mes Julio de 2018	\N	\N	342-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
382	129	3	Personal Eventual - Mes Julio de 2018	\N	\N	342-18	28	5000.00	4666.67	466.67	79.80	23.33	23.33	0.00	593.13	4073.53	0.00	0.00	0.00	593.13	4073.53	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
384	53	3	Personal Eventual - Mes Julio de 2018	\N	\N	344-18	2	4400.00	293.33	29.33	5.02	1.47	1.47	0.00	37.28	256.05	0.00	0.00	0.00	37.28	256.05	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
385	130	3	Personal Eventual - Mes Julio de 2018	\N	\N	344-18	28	4400.00	4106.67	410.67	70.22	20.53	20.53	0.00	521.96	3584.71	0.00	0.00	0.00	521.96	3584.71	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
386	54	3	Personal Eventual - Mes Julio de 2018	\N	\N	345-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
387	56	3	Personal Eventual - Mes Julio de 2018	\N	\N	346-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
388	87	3	Personal Eventual - Mes Julio de 2018	\N	\N	347-18	2	2850.00	190.00	19.00	3.25	0.95	0.95	0.00	24.15	165.85	0.00	0.00	0.00	24.15	165.85	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
389	155	3	Personal Eventual - Mes Julio de 2018	\N	\N	347-18	28	2850.00	2660.00	266.00	45.49	13.30	13.30	0.00	338.09	2321.91	0.00	0.00	0.00	338.09	2321.91	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
390	99	3	Personal Eventual - Mes Julio de 2018	\N	\N	348-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
392	159	3	Personal Eventual - Mes Julio de 2018	\N	\N	350-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	166.66	166.66	802.16	4197.84	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
393	88	3	Personal Eventual - Mes Julio de 2018	\N	\N	351-18	2	2850.00	190.00	19.00	3.25	0.95	0.95	0.00	24.15	165.85	0.00	0.00	0.00	24.15	165.85	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
394	154	3	Personal Eventual - Mes Julio de 2018	\N	\N	351-18	28	2850.00	2660.00	266.00	45.49	13.30	13.30	0.00	338.09	2321.91	0.00	0.00	0.00	338.09	2321.91	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
395	58	3	Personal Eventual - Mes Julio de 2018	\N	\N	352-18	2	4400.00	293.33	29.33	5.02	1.47	1.47	0.00	37.28	256.05	0.00	0.00	0.00	37.28	256.05	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
396	131	3	Personal Eventual - Mes Julio de 2018	\N	\N	352-18	28	4400.00	4106.67	410.67	70.22	20.53	20.53	0.00	521.96	3584.71	0.00	0.00	0.00	521.96	3584.71	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
399	60	3	Personal Eventual - Mes Julio de 2018	\N	\N	354-18	2	3500.00	233.33	23.33	3.99	1.17	1.17	0.00	29.66	203.68	0.00	0.00	0.00	29.66	203.68	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
397	59	3	Personal Eventual - Mes Julio de 2018	\N	\N	353-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
408	141	3	Personal Eventual - Mes Julio de 2018	\N	\N	359-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	650.00	650.00	1112.64	2527.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
344	31	3	Personal Eventual - Mes Julio de 2018	\N	\N	318-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
415	135	3	Personal Eventual - Mes Julio de 2018	\N	\N	365-18	28	3900.00	3640.00	364.00	62.24	18.20	18.20	0.00	462.64	3177.36	0.00	195.00	195.00	657.64	2982.36	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
417	68	3	Personal Eventual - Mes Julio de 2018	\N	\N	367-18	2	3500.00	233.33	23.33	3.99	1.17	1.17	0.00	29.66	203.68	0.00	0.00	0.00	29.66	203.68	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
418	136	3	Personal Eventual - Mes Julio de 2018	\N	\N	367-18	28	3500.00	3266.67	326.67	55.86	16.33	16.33	0.00	415.19	2851.47	0.00	0.00	0.00	415.19	2851.47	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
279	2	3	Personal Eventual - Mes Julio de 2018	\N	\N	275-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
276	138	3	Personal Eventual - Mes Julio de 2018	\N	\N	273-18	7	6200.00	1446.67	144.67	24.74	7.23	7.23	0.00	183.87	1262.80	0.00	0.00	0.00	183.87	1262.80	2018-07-31 12:24:42	2018-07-31 13:13:09	0	0	0
400	133	3	Personal Eventual - Mes Julio de 2018	\N	\N	354-18	28	3500.00	3266.67	326.67	55.86	16.33	16.33	0.00	415.19	2851.47	0.00	0.00	0.00	415.19	2851.47	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
401	72	3	Personal Eventual - Mes Julio de 2018	\N	\N	355-18	2	3000.00	200.00	20.00	3.42	1.00	1.00	0.00	25.42	174.58	0.00	0.00	0.00	25.42	174.58	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
402	142	3	Personal Eventual - Mes Julio de 2018	\N	\N	355-18	28	3000.00	2800.00	280.00	47.88	14.00	14.00	0.00	355.88	2444.12	0.00	0.00	0.00	355.88	2444.12	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
404	62	3	Personal Eventual - Mes Julio de 2018	\N	\N	357-18	2	4400.00	293.33	29.33	5.02	1.47	1.47	0.00	37.28	256.05	0.00	0.00	0.00	37.28	256.05	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
405	140	3	Personal Eventual - Mes Julio de 2018	\N	\N	357-18	28	4400.00	4106.67	410.67	70.22	20.53	20.53	0.00	521.96	3584.71	0.00	0.00	0.00	521.96	3584.71	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
406	92	3	Personal Eventual - Mes Julio de 2018	\N	\N	358-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
409	64	3	Personal Eventual - Mes Julio de 2018	\N	\N	360-18	2	6200.00	413.33	41.33	7.07	2.07	2.07	0.00	52.53	360.80	0.00	0.00	0.00	52.53	360.80	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
410	134	3	Personal Eventual - Mes Julio de 2018	\N	\N	361-18	28	6200.00	5786.67	578.67	98.95	28.93	28.93	0.00	735.49	5051.18	0.00	0.00	0.00	735.49	5051.18	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
411	76	3	Personal Eventual - Mes Julio de 2018	\N	\N	362-18	2	2850.00	190.00	19.00	3.25	0.95	0.95	0.00	24.15	165.85	0.00	0.00	0.00	24.15	165.85	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
412	146	3	Personal Eventual - Mes Julio de 2018	\N	\N	362-18	28	2850.00	2660.00	266.00	45.49	13.30	13.30	0.00	338.09	2321.91	0.00	0.00	0.00	338.09	2321.91	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
413	65	3	Personal Eventual - Mes Julio de 2018	\N	\N	363-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
416	170	3	Personal Eventual - Mes Julio de 2018	\N	\N	366-18	30	6900.00	6900.00	690.00	117.99	34.50	34.50	0.00	876.99	6023.01	0.00	0.00	0.00	876.99	6023.01	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
419	69	3	Personal Eventual - Mes Julio de 2018	\N	\N	368-18	30	4400.00	4400.00	440.00	75.24	22.00	22.00	0.00	559.24	3840.76	0.00	0.00	0.00	559.24	3840.76	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
420	81	3	Personal Eventual - Mes Julio de 2018	\N	\N	369-18	2	4500.00	300.00	30.00	5.13	1.50	1.50	0.00	38.13	261.87	0.00	0.00	0.00	38.13	261.87	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
421	151	3	Personal Eventual - Mes Julio de 2018	\N	\N	369-18	28	4500.00	4200.00	420.00	71.82	21.00	21.00	0.00	533.82	3666.18	0.00	0.00	0.00	533.82	3666.18	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
422	74	3	Personal Eventual - Mes Julio de 2018	\N	\N	370-18	2	2850.00	190.00	19.00	3.25	0.95	0.95	0.00	24.15	165.85	0.00	0.00	0.00	24.15	165.85	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
423	144	3	Personal Eventual - Mes Julio de 2018	\N	\N	370-18	28	2850.00	2660.00	266.00	45.49	13.30	13.30	0.00	338.09	2321.91	0.00	0.00	0.00	338.09	2321.91	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
424	70	3	Personal Eventual - Mes Julio de 2018	\N	\N	371-18	2	5000.00	333.33	33.33	5.70	1.67	1.67	0.00	42.37	290.97	0.00	0.00	0.00	42.37	290.97	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
425	137	3	Personal Eventual - Mes Julio de 2018	\N	\N	371-18	28	5000.00	4666.67	466.67	79.80	23.33	23.33	0.00	593.13	4073.53	0.00	0.00	0.00	593.13	4073.53	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
297	156	3	Personal Eventual - Mes Julio de 2018	\N	\N	286-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	0.00	0.00	635.50	4364.50	2018-07-31 12:24:42	2018-07-31 13:13:10	0	0	0
346	158	3	Personal Eventual - Mes Julio de 2018	\N	\N	319-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	166.66	166.66	802.16	4197.84	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
391	171	3	Personal Eventual - Mes Julio de 2018	\N	\N	349-18	30	3900.00	3900.00	390.00	66.69	19.50	19.50	0.00	495.69	3404.31	0.00	0.00	0.00	495.69	3404.31	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
407	63	3	Personal Eventual - Mes Julio de 2018	\N	\N	359-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
373	98	3	Personal Eventual - Mes Julio de 2018	\N	\N	336-18	30	5000.00	5000.00	500.00	85.50	25.00	25.00	0.00	635.50	4364.50	0.00	249.99	249.99	885.49	4114.51	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
414	66	3	Personal Eventual - Mes Julio de 2018	\N	\N	364-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
317	18	3	Personal Eventual - Mes Julio de 2018	\N	\N	301-18	2	3900.00	260.00	26.00	4.45	1.30	1.30	0.00	33.05	226.95	0.00	0.00	0.00	33.05	226.95	2018-07-31 12:24:43	2018-07-31 13:13:10	0	0	0
\.


--
-- Data for Name: position_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.position_groups (id, name, shortened, created_at, updated_at, employer_number_id) FROM stdin;
28	REPRESENTACIÓN DEPARTAMENTAL BENI		2018-05-30 12:59:59	2018-05-30 12:59:59	1
26	REPRESENTACIÓN DEPARTAMENTAL POTOSI		2018-05-30 12:59:59	2018-05-30 12:59:59	1
25	REPRESENTACIÓN DEPARTAMENTAL CHUQUISACA		2018-05-30 12:59:59	2018-05-30 12:59:59	1
22	REPRESENTACIÓN DEPARTAMENTAL SANTA CRUZ		2018-05-30 12:59:59	2018-05-30 12:59:59	2
23	REPRESENTACIÓN DEPARTAMENTAL COCHABAMBA		2018-05-30 12:59:59	2018-05-30 12:59:59	1
20	UNIDAD INTEGRAL ADMINISTRATIVA INSTITUCIONAL		2018-05-30 12:59:59	2018-05-30 12:59:59	1
21	UNIDAD INTEGRAL DE DEFENSA Y REPRESENTACIÓN INSTITUC.		2018-05-30 12:59:59	2018-05-30 12:59:59	1
18	UNIDAD DE SISTEMAS Y SOPORTE TÉCNICO		2018-05-30 12:59:59	2018-05-30 12:59:59	1
19	DIRECCIÓN DE ASESORAMIENTO JURÍDICO ADMIN. Y DEF. INST.		2018-05-30 12:59:59	2018-05-30 12:59:59	1
16	UNIDAD ADMINISTRATIVA		2018-05-30 12:59:59	2018-05-30 12:59:59	1
17	UNIDAD DE RECURSOS HUMANOS		2018-05-30 12:59:59	2018-05-30 12:59:59	1
14	DIRECCIÓN DE ASUNTOS ADMINISTRATIVOS		2018-05-30 12:59:59	2018-05-30 12:59:59	1
15	UNIDAD FINANCIERA		2018-05-30 12:59:59	2018-05-30 12:59:59	1
12	UNIDAD DE OTOR. FONDO DE RET. POL. IND. CUOTA Y AUXILIO MORT.		2018-05-30 12:59:59	2018-05-30 12:59:59	1
13	UNIDAD DE OTORGACIÓN DEL COMPLEMENTO ECONÓMICO		2018-05-30 12:59:59	2018-05-30 12:59:59	1
10	HOSTAL PARÍS		2018-05-30 12:59:59	2018-05-30 12:59:59	1
11	DIRECCIÓN DE BENEFICIOS ECONÓMICOS		2018-05-30 12:59:59	2018-05-30 12:59:59	1
8	UNIDAD DE INVERSIÓN EN PRÉSTAMO		2018-05-30 12:59:59	2018-05-30 12:59:59	1
9	UNIDAD DE INVERSIÓN EN SERVICIOS, BIENES Y PATRIMONIO		2018-05-30 12:59:59	2018-05-30 12:59:59	1
6	UNIDAD DE GESTIÓN DOCUMENTAL Y ARCHIVO		2018-05-30 12:59:59	2018-05-30 12:59:59	1
7	DIRECCIÓN DE ESTRATEGIAS SOCIALES E INVERSIONES		2018-05-30 12:59:59	2018-05-30 12:59:59	1
4	UNIDAD DE TRANSPARENCIA INSTITUCIONAL		2018-05-30 12:59:59	2018-05-30 12:59:59	1
5	UNIDAD DE PLANIFICACIÓN ORGANIZACIÓN Y MÉTODOS		2018-05-30 12:59:59	2018-05-30 12:59:59	1
2	HONORABLE DIRECTORIO		2018-05-30 12:59:59	2018-05-30 12:59:59	1
3	UNIDAD DE AUDITORÍA INTERNA		2018-05-30 12:59:59	2018-05-30 12:59:59	1
24	REPRESENTACIÓN DEPARTAMENTAL ORURO		2018-05-30 12:59:59	2018-05-30 12:59:59	5
1	DIRECCIÓN GENERAL EJECUTIVA	DGE	2018-05-30 12:59:59	2018-05-30 12:59:59	1
29	REPRESENTACIÓN DEPARTAMENTAL PANDO		2018-05-30 12:59:59	2018-05-30 12:59:59	3
27	REPRESENTACIÓN DEPARTAMENTAL TARIJA		2018-05-30 12:59:59	2018-05-30 12:59:59	4
\.


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.positions (id, charge_id, position_group_id, item, name, shortened, created_at, updated_at) FROM stdin;
1	1	1	1	Director General Ejecutivo	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
2	10	1	2	Secretaria de Dirección	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
3	11	1	3	Asistente de Dirección	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
4	11	1	4	Asistente y Mensajero	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
5	6	2	5	Asesor Jurídico de Directorio	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
6	6	2	6	Asesor Financiero de Directorio	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
7	10	2	7	Secretaria de Honorable Directorio	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
8	3	3	8	Jefe de Unidad de Auditoria Interna	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
9	7	3	9	Auditor Interno I	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
10	7	3	10	Auditor Interno II	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
13	7	6	13	Encargado de la Unidad de Gestión Documental y Archivo	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
14	13	6	14	Asistente de Registro y Despacho de Correspondencia	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
15	2	7	15	Director de Estrategias Sociales e Inversiones	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
16	10	7	16	Secretaria de Dirección	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
17	3	8	17	Jefe de Unidad de Inversión de Prestamos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
18	7	8	18	Analista Legal Prestamos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
19	10	8	19	Encargado de Calificación de Prestamos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
20	10	8	20	Técnico de Atención al Afiliado I	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
21	10	8	21	Técnico de Atención al Afiliado II	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
22	10	8	22	Técnico de Atención al Afiliado III	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
23	5	8	23	Encargado de Registro, Control y Recuperación de Prestamos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
24	10	8	24	Técnico de Recuperación y Cobranzas	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
25	4	9	25	Jefe de Unidad de Inversión en Servicios, Bienes y Patrimonio	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
26	5	9	26	Encargado de Procesos Técnicos de Patrimonio y Bienes	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
27	10	9	27	Técnico de Conservación, Patrimonio y Bienes	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
28	12	9	28	Asistente de Conservación, Patrimonio y Bienes	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
29	9	10	29	Profesional Administrativo de Hostal Paris	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
30	10	10	30	Asistente de Recepción Diurna I	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
31	10	10	31	Asistente de Recepción Diurna II	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
32	13	10	32	Asistente de Recepción Nocturno	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
33	13	10	33	Asistente Turnante	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
34	13	10	34	Asistente Camarero	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
35	2	11	35	Director de Beneficios Económicos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
36	10	11	36	Secretaria de Dirección	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
37	10	11	37	Profesional de Archivo y Gestión Documental de Beneficios Económicos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
38	9	11	38	Profesional de Trabajo Social	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
39	3	12	39	Jefe de Unidad de Otorgación de Fondo de Retiro Policial Individual Cuota y Auxilio Mortuorio	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
40	7	12	40	Analista Legal Fondo de Retiro Cuota y Auxilio Mortuorio	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
41	10	12	41	Técnico de Atención al Afiliado Fondo de Retiro	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
42	7	12	42	Encargado de Calificación de Fondo de Retiro Cuota y Auxilio Mortuorio	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
43	10	12	43	Técnico de Procesos de Calificación de Fondo de Retiro, Cuota y Auxilio Mortuorio	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
44	7	12	44	Encargado de Cuentas Individuales	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
45	10	12	45	Técnico de Control de Aportes	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
46	3	13	46	Jefe de Unidad de Otorgación del Complemento Económico	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
47	7	13	47	Analista Legal del Complemento Económico	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
48	9	13	48	Técnico de Atención al Afiliado Complemento Económico	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
49	9	13	49	Encargado de Calificación Complemento Económico	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
50	10	13	50	Técnico de Verificación y Validación Documental	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
51	10	13	51	Técnico de Procesos de Calificación Complemento Económico	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
52	10	13	52	Encargado de Organización y Logística	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
53	2	14	53	Director de Asuntos Administrativos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
54	10	14	54	Secretaria de Dirección	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
55	3	15	55	Jefe de Unidad Financiera	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
56	5	15	56	Responsable de Contabilidad Integrada	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
57	7	15	57	Analista de Sistemas Contable 1	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
58	7	15	58	Analista de Procesos de Información Contable	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
59	11	15	59	Técnico de Archivo y Manejo de Documentos Contables	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
61	7	15	61	Analista Contable de Inversiones	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
62	5	15	62	Responsable de Tesorería	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
63	7	15	63	Analista de Ingresos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
64	10	15	64	Técnico de Recepción de Aportes y Caja General	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
65	5	15	65	Responsable de Programación y Ejecución Presupuestaria	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
66	10	15	66	Técnico de Procesamiento y Registro Presupuestario	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
68	7	16	68	Analista de Contratación y Adquisiciones	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
69	7	16	69	Profesional en Servicios Generales y Trámites Administrativos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
70	7	16	70	Analista en Activos Fijos y Almacenes	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
11	4	4	11	Jefe de Unidad de Transparencia Institucional	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
72	10	17	72	Técnico en Recursos Humanos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
74	7	18	74	Analista de Desarrollo y Mantenimiento de Software	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
75	7	18	75	Profesional Soporte Técnico	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
76	7	18	76	Analista en Programación de Sistemas	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
77	2	19	77	Director de Asesoramiento Jurídico, Administrativo y Defensa Institucional	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
78	10	19	78	Secretaria de Dirección	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
80	7	20	80	Analista Jurídico Administrativo	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
81	9	20	81	Analista de Procesos Administrativos y Contratos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
83	7	21	83	Analista de Procesos Judiciales y Arbitrales	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
84	9	21	84	Analista de Procesos Especiales y Recuperación Patrimonial	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
85	8	22	85	Representante Departamental Santa Cruz	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
86	13	22	86	Asistente Administrativo Sta. Cruz	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
87	8	23	87	Representante Departamental Cochabamba	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
88	13	23	88	Asistente Administrativo Cbba.	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
89	12	24	89	Asistente Departamental Oruro	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
90	12	25	90	Asistente Departamental Chuquisaca	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
91	12	26	91	Asistente Departamental Potosí	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
92	8	27	92	Representante Departamental Tarija	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
93	8	28	93	Representante Departamental Beni	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
94	8	29	94	Representante Departamental Pando	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
60	10	15	60	Analista Contable de Fondos en Avance	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
95	9	5	0	Consultor Individual de Línea	\N	2018-06-22 15:19:41	2018-06-22 15:19:42
71	4	17	71	Jefe de Unidad de Recursos Humanos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
67	3	16	67	Jefe de Unidad Administrativa	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
12	4	5	12	Jefe de Unidad de Planificación, Organización y Métodos	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
73	4	18	73	Jefe de Unidad de Sistemas y Soportes Técnico	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
82	4	21	82	Jefe de Unidad de Defensa y Representación Institucional	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
79	4	20	79	Jefe de Unidad Integral Administrativa Institucional	\N	2018-05-30 12:59:59	2018-05-30 12:59:59
\.


--
-- Data for Name: procedures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.procedures (id, month_id, year, name, discount_old, discount_common_risk, discount_commission, discount_solidary, discount_national, discount_rc_iva, discount_faults, created_at, updated_at, contribution_insurance_company, contribution_professional_risk, contribution_employer_solidary, contribution_employer_housing) FROM stdin;
2	5	2018	mayo	10.00	1.71	0.50	0.50	0.00	13.00	0.00	2018-06-18 18:25:07	2018-06-18 18:25:08	10.00	1.71	3.00	2.00
1	4	2018	mese de ...	10.00	1.71	0.50	0.50	0.00	13.00	0.00	2018-05-30 12:59:59	2018-05-30 12:59:59	10.00	1.71	3.00	2.00
3	7	2018		10.00	1.71	0.50	0.50	0.00	13.00	0.00	2018-07-04 17:19:29	2018-07-04 17:19:29	0.00	0.00	0.00	0.00
4	6	2018	junio	10.00	1.71	0.50	0.50	0.00	13.00	0.00	2018-07-05 15:00:27	2018-07-05 15:00:27	10.00	1.71	3.00	2.00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, password, remember_token, created_at, updated_at, username) FROM stdin;
2	$2y$10$RWi.n6S8DT7tZBvfooh3QeDHI67TwmvXmhGKhRiYEBMDBjV.6oDNe	\N	2018-07-06 16:08:28	2018-07-06 16:17:07	jmorales
3	$2y$10$UUPvN0.6I5GsEsROATvpU.MzDcGsIU6aWkD15IZjZjLrd8U9Pi1du	WTuX9thbA0h2InPthlH5uvqrX2XeztNLn1kglCfcxouBJNGFz5rtgeGnoIIr	2018-07-06 16:15:22	2018-07-06 16:15:22	sponce
1	$2y$10$JEUzzJz4V92ccnrPeVpkreuwohnmgyJCBQ1MMFHjJRwJrBzxY60KG	oYHZIu1JTOCrwiPyWg12koh601GqCX709EdTDv2vW4Hx8BLgXFTE45fJ4Np8	2018-07-06 16:04:30	2018-07-06 16:04:30	admin
\.


--
-- Name: charges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.charges_id_seq', 13, true);


--
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 9, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, true);


--
-- Name: consultancy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consultancy_id_seq', 1, false);


--
-- Name: contract_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contract_types_id_seq', 4, true);


--
-- Name: contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contracts_id_seq', 175, true);


--
-- Name: employee_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_types_id_seq', 3, true);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_id_seq', 100, true);


--
-- Name: employer_numbers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employer_numbers_id_seq', 5, true);


--
-- Name: insurance_companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.insurance_companies_id_seq', 2, true);


--
-- Name: job_schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_schedules_id_seq', 5, true);


--
-- Name: management_entities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.management_entities_id_seq', 2, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 33, true);


--
-- Name: months_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.months_id_seq', 12, true);


--
-- Name: payrolls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payrolls_id_seq', 425, true);


--
-- Name: position_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.position_groups_id_seq', 29, true);


--
-- Name: positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.positions_id_seq', 95, true);


--
-- Name: procedures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.procedures_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: charges charges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.charges
    ADD CONSTRAINT charges_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: consultancy consultancy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultancy
    ADD CONSTRAINT consultancy_pkey PRIMARY KEY (id);


--
-- Name: contract_types contract_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_types
    ADD CONSTRAINT contract_types_pkey PRIMARY KEY (id);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id);


--
-- Name: employee_types employee_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_types
    ADD CONSTRAINT employee_types_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: employer_numbers employer_numbers_number_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employer_numbers
    ADD CONSTRAINT employer_numbers_number_unique UNIQUE (number);


--
-- Name: employer_numbers employer_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employer_numbers
    ADD CONSTRAINT employer_numbers_pkey PRIMARY KEY (id);


--
-- Name: insurance_companies insurance_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.insurance_companies
    ADD CONSTRAINT insurance_companies_pkey PRIMARY KEY (id);


--
-- Name: job_schedules job_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_schedules
    ADD CONSTRAINT job_schedules_pkey PRIMARY KEY (id);


--
-- Name: management_entities management_entities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.management_entities
    ADD CONSTRAINT management_entities_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: months months_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.months
    ADD CONSTRAINT months_pkey PRIMARY KEY (id);


--
-- Name: payrolls payrolls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payrolls
    ADD CONSTRAINT payrolls_pkey PRIMARY KEY (id);


--
-- Name: position_groups position_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.position_groups
    ADD CONSTRAINT position_groups_pkey PRIMARY KEY (id);


--
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);


--
-- Name: procedures procedures_month_id_year_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedures
    ADD CONSTRAINT procedures_month_id_year_unique UNIQUE (month_id, year);


--
-- Name: procedures procedures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedures
    ADD CONSTRAINT procedures_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);


--
-- Name: contract_job_schedule contract_job_schedule_contract_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_job_schedule
    ADD CONSTRAINT contract_job_schedule_contract_id_foreign FOREIGN KEY (contract_id) REFERENCES public.contracts(id) ON DELETE CASCADE;


--
-- Name: contract_job_schedule contract_job_schedule_job_schedule_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_job_schedule
    ADD CONSTRAINT contract_job_schedule_job_schedule_id_foreign FOREIGN KEY (job_schedule_id) REFERENCES public.job_schedules(id) ON DELETE CASCADE;


--
-- Name: contracts contracts_consultancy_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_consultancy_id_foreign FOREIGN KEY (consultancy_id) REFERENCES public.consultancy(id);


--
-- Name: contracts contracts_contracts_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_contracts_type_id_foreign FOREIGN KEY (contracts_type_id) REFERENCES public.contract_types(id);


--
-- Name: contracts contracts_employee_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_employee_id_foreign FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- Name: contracts contracts_position_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_position_id_foreign FOREIGN KEY (position_id) REFERENCES public.positions(id);


--
-- Name: employees employees_city_birth_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_city_birth_id_foreign FOREIGN KEY (city_birth_id) REFERENCES public.cities(id);


--
-- Name: employees employees_city_identity_card_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_city_identity_card_id_foreign FOREIGN KEY (city_identity_card_id) REFERENCES public.cities(id);


--
-- Name: employees employees_employee_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_employee_type_id_foreign FOREIGN KEY (employee_type_id) REFERENCES public.employee_types(id);


--
-- Name: employees employees_insurance_company_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_insurance_company_id_foreign FOREIGN KEY (insurance_company_id) REFERENCES public.insurance_companies(id);


--
-- Name: employees employees_management_entity_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_management_entity_id_foreign FOREIGN KEY (management_entity_id) REFERENCES public.management_entities(id);


--
-- Name: payrolls payrolls_contract_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payrolls
    ADD CONSTRAINT payrolls_contract_id_foreign FOREIGN KEY (contract_id) REFERENCES public.contracts(id);


--
-- Name: payrolls payrolls_procedure_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payrolls
    ADD CONSTRAINT payrolls_procedure_id_foreign FOREIGN KEY (procedure_id) REFERENCES public.procedures(id);


--
-- Name: position_groups position_groups_employer_number_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.position_groups
    ADD CONSTRAINT position_groups_employer_number_id_foreign FOREIGN KEY (employer_number_id) REFERENCES public.employer_numbers(id);


--
-- Name: positions positions_charge_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_charge_id_foreign FOREIGN KEY (charge_id) REFERENCES public.charges(id);


--
-- Name: positions positions_position_group_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_position_group_id_foreign FOREIGN KEY (position_group_id) REFERENCES public.position_groups(id);


--
-- Name: procedures procedures_month_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedures
    ADD CONSTRAINT procedures_month_id_foreign FOREIGN KEY (month_id) REFERENCES public.months(id);


--
-- PostgreSQL database dump complete
--

