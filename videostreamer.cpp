#include "videostreamer.h"

VideoStreamer::VideoStreamer()
{
    connect(&tUpdate,&QTimer::timeout,this,&VideoStreamer::streamVideo);

}

VideoStreamer::~VideoStreamer()
{
    cap.release();
    tUpdate.stop();
}

void VideoStreamer::streamVideo()
{
    cap>>frame;


    QImage img = QImage(frame.data,frame.cols,frame.rows,QImage::Format_RGB888).rgbSwapped();
    emit newImage(img);
}

void VideoStreamer::openVideoCamera(QString path)
{
    if(path.length() == 1)
    cap.open(path.toInt());
    else
    cap.open(path.toStdString());

    double fps = cap.get(cv::CAP_PROP_FPS);
    tUpdate.start(1000/fps);
}
