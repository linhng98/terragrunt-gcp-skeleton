root-ca.key:
	@echo "generating $@"
	@openssl genrsa -out $@ 2048

root-ca.csr: root-ca.key root-ca.conf
	@echo "generating $@"
	@openssl req -new -key $< -config root-ca.conf -out $@

root-ca.cert: root-ca.csr root-ca.key
	@echo "generating $@"
	@openssl x509 -req -signkey root-ca.key \
		-extensions req_ext -extfile root-ca.conf \
		-in $< -out $@
