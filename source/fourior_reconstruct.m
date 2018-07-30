% void AnalysisModule::fourierReconstruct(std::vector<std::vector<double>> coeffs, std::vector<cv::Point2f> & cFit, int nPoints){

	cFit.resize(nPoints);

	//theta goes from -PI to PI in nPoints steps
	double theta = -M_PI;
	double thetaStep = 2.0*M_PI/double(nPoints);

	for(int i=0; i<cFit.size(); i++) cFit[i] = cv::Point2f(0,0);  //initialize points

	for(int i=0; i<coeffs.size(); i++){
		theta = -M_PI;
		for(int j=0; j<cFit.size(); j++){
			cFit[j].x += coeffs[i][AX] * cos(double(i) * theta) + coeffs[i][BX]*sin(double(i) * theta);
			cFit[j].y += coeffs[i][AY] * cos(double(i) * theta) + coeffs[i][BY]*sin(double(i) * theta);
			theta += thetaStep;
		}
	}

};
