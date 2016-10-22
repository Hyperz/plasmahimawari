/*
 *  Copyright 2016 Hyperz
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick 2.0
import QtQuick.Window 2.0
import "../code/Himawari.js" as Himawari

Rectangle {

    property int imageSize: 550
    property int optimalDetailLevel: 2
    
    id: root
    width: Screen.width
    height: Screen.height
    color: "black"

    GridView {

        id: imageGrid
        width: root.imageSize * root.optimalDetailLevel
        height: root.imageSize * root.optimalDetailLevel
        cellWidth: root.imageSize
        cellHeight: root.imageSize
        anchors.centerIn: parent

        model: ListModel {

            id: imageGridModel

        }

        delegate: Image {

            width: root.imageSize
            height: root.imageSize
            asynchronous: true
            source: image

        }

    }

    Timer {

        id: updateTimer
        running: true
        repeat: true
        triggeredOnStart: true
        interval: 15 * (60 * 1000) // TODO: make this configurable
        onTriggered: {

            var callback = function(urls) {

                var rebuild = (urls.length !== imageGridModel.count);

                if (rebuild)

                    imageGridModel.clear();

                for (var i = 0; i < urls.length; i++) {

                    if (rebuild)

                        imageGridModel.append({image: urls[i]});

                    else

                        imageGridModel.setProperty(i, "image", urls[i]);

                }


                imageGridModel.sync();

            }

            root.optimalDetailLevel = Himawari.getOptimalDetailLevel(root.width, root.height, root.imageSize);
            Himawari.getLatest(root.optimalDetailLevel, root.imageSize, callback);
            
        }
    }
    
}

