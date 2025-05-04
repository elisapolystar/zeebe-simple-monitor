CREATE TABLE public.element_instance_new
(
    id                      character varying(255) NOT NULL,
    bpmn_element_type_      character varying,
    element_id_             character varying(255),
    flow_scope_key_         bigint,
    intent_                 character varying,
    key_                    bigint,
    partition_id_           integer,
    position_               bigint,
    process_definition_key_ bigint,
    process_instance_key_   bigint,
    timestamp_              bigint
) PARTITION BY HASH (process_definition_key_);

ALTER TABLE public.element_instance_new ADD PRIMARY KEY (id, process_definition_key_);

CREATE INDEX element_instance_processinstancekeyindexnew ON public.element_instance_new USING btree (process_instance_key_);
CREATE INDEX idx_compositenew ON ELEMENT_INSTANCE_NEW (PROCESS_DEFINITION_KEY_, INTENT_, BPMN_ELEMENT_TYPE_, ELEMENT_ID_);

CREATE TABLE element_instance_p0 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 0);
CREATE TABLE element_instance_p1 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 1);
CREATE TABLE element_instance_p2 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 2);
CREATE TABLE element_instance_p3 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 3);
CREATE TABLE element_instance_p4 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 4);
CREATE TABLE element_instance_p5 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 5);
CREATE TABLE element_instance_p6 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 6);
CREATE TABLE element_instance_p7 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 7);
CREATE TABLE element_instance_p8 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 8);
CREATE TABLE element_instance_p9 PARTITION OF element_instance_new FOR VALUES WITH (MODULUS 10, REMAINDER 9);

INSERT INTO element_instance_new (id, bpmn_element_type_, element_id_, flow_scope_key_, intent_, key_, partition_id_, position_, process_definition_key_, process_instance_key_, timestamp_)
SELECT id, bpmn_element_type_, element_id_, flow_scope_key_, intent_, key_, partition_id_, position_, process_definition_key_, process_instance_key_, timestamp_ FROM element_instance;

ALTER TABLE element_instance RENAME TO element_instance_old;
ALTER TABLE element_instance_new RENAME TO element_instance;