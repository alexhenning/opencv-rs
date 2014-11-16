extern crate opencv;
extern crate libc;

// use networktables;
use opencv::_unsafe as cv;

fn main() {
    unsafe {
	    let mut img = cv::cvLoadImage(c_str("lena512.bmp"), cv::CV_LOAD_IMAGE_COLOR);
        println!("Image: {}", img);
	    println!("Window: {}", cv::cvNamedWindow(c_str("Example1"), cv::CV_WINDOW_AUTOSIZE as i32));
	    println!("Show Image: {}", cv::cvShowImage(c_str("Example1"),
                                                   img as *const libc::types::common::c95::c_void ));
	    println!("Wait Key: {}", cv::cvWaitKey(0));
	    println!("Release Image: {}", cv::cvReleaseImage( &mut img ));
	    println!("Destroy Window: {}", cv::cvDestroyWindow(c_str("Example1")));
    }
}

fn c_str(s: &str) -> *const i8 {
    unsafe { s.to_c_str().unwrap() }
}
