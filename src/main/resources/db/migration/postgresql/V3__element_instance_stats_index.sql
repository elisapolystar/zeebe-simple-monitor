CREATE INDEX element_instance_statisticsqueryindex ON public.element_instance USING btree (process_definition_key_, intent_, bpmn_element_type_);
