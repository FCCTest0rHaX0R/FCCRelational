--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22),
    games_played integer,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (12, 'user_1714317581940', 0, 0);
INSERT INTO public.users VALUES (13, 'user_1714317581939', 0, 0);
INSERT INTO public.users VALUES (14, 'atharvi', 0, 0);
INSERT INTO public.users VALUES (15, 'user_1714319275524', 0, 0);
INSERT INTO public.users VALUES (16, 'user_1714319275523', 0, 0);
INSERT INTO public.users VALUES (17, 'user_1714319288703', 0, 0);
INSERT INTO public.users VALUES (18, 'user_1714319288702', 0, 0);
INSERT INTO public.users VALUES (19, 'user_1714319358493', 0, 0);
INSERT INTO public.users VALUES (20, 'user_1714319358492', 0, 0);
INSERT INTO public.users VALUES (21, 'user_1714319647568', 0, 0);
INSERT INTO public.users VALUES (22, 'user_1714319647567', 0, 0);
INSERT INTO public.users VALUES (23, 'user_1714319928228', 0, 0);
INSERT INTO public.users VALUES (24, 'user_1714319928227', 0, 0);
INSERT INTO public.users VALUES (25, 'user_1714319931366', 0, 0);
INSERT INTO public.users VALUES (26, 'user_1714319931365', 0, 0);
INSERT INTO public.users VALUES (27, 'user_1714320014307', 0, 0);
INSERT INTO public.users VALUES (28, 'user_1714320014306', 0, 0);
INSERT INTO public.users VALUES (29, 'user_1714320029864', 0, 0);
INSERT INTO public.users VALUES (30, 'user_1714320029863', 0, 0);
INSERT INTO public.users VALUES (31, 'user_1714320097217', 0, 0);
INSERT INTO public.users VALUES (32, 'user_1714320097216', 0, 0);
INSERT INTO public.users VALUES (33, 'user_1714320100716', 0, 0);
INSERT INTO public.users VALUES (34, 'user_1714320100715', 0, 0);
INSERT INTO public.users VALUES (35, 'user_1714320528187', 0, 0);
INSERT INTO public.users VALUES (36, 'user_1714320528186', 0, 0);
INSERT INTO public.users VALUES (37, 'user_1714320778447', 0, 323);
INSERT INTO public.users VALUES (38, 'user_1714320778446', 0, 805);
INSERT INTO public.users VALUES (40, 'user_1714320781765', 0, 127);
INSERT INTO public.users VALUES (39, 'user_1714320781766', 0, 62);
INSERT INTO public.users VALUES (43, 'user_1714320866722', 0, 361);
INSERT INTO public.users VALUES (42, 'user_1714320866723', 0, 67);
INSERT INTO public.users VALUES (45, 'user_1714320891342', 2, 50);
INSERT INTO public.users VALUES (44, 'user_1714320891343', 5, 237);
INSERT INTO public.users VALUES (41, 'guniii', 1, 7);
INSERT INTO public.users VALUES (47, 'user_1714320933959', 2, 372);
INSERT INTO public.users VALUES (46, 'user_1714320933960', 5, 154);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 47, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- PostgreSQL database dump complete
--

