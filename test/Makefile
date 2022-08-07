all : result.make.stub.sh result.clear.callcount result.sample.sh

result.make.stub.sh : make.stub.sh_test.sh
	@./make.stub.sh_test.sh | tee result.make.stub.sh

result.clear.callcount: clear.callcount_test.sh
	@./clear.callcount_test.sh| tee result.clear.callcount

result.sample.sh : sample_test.sh
	@./sample_test.sh | tee result.sample.sh


.PHONY: clean
clean:
	rm -f result.*
