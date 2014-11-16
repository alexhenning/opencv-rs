
BINDGEN = external/rust-bindgen/target/bindgen

LD_FIXES = LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libclang.so LD_LIBRARY_PATH=external/rust-bindgen/target
INCLUDES = -I/usr/lib/clang/3.4/include/ -Iexternal/opencv/include/ $(patsubst %,-I%,$(wildcard external/opencv/modules/*/include))
LIBS = -lopencv_core \
	   -lopencv_imgproc \
	   -lopencv_highgui \
	   -lopencv_objdetect \
	   -lopencv_calib3d \

cargo: src/_unsafe.rs
	cargo build

test:
	cargo test

clean:
	cargo clean
	rm src/_unsafe.rs

bindings: src/_unsafe.rs

src/_unsafe.rs: $(BINDGEN)
	echo "#![allow(non_camel_case_types)]" > src/_unsafe.rs
	echo "#![allow(non_snake_case)]" >> src/_unsafe.rs
	echo "#![allow(non_upper_case_globals)]" >> src/_unsafe.rs
	$(LD_FIXES) $(BINDGEN) $(LIBS) $(INCLUDES) src/opencv.h >> src/_unsafe.rs

$(BINDGEN):
	cd external/rust-bindgen && cargo build
