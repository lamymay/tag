import Foundation
// 导入 C++ 的 TagLib 库 import taglib

struct FileTool {
    
    // 音频文件扩展名集合
    static let audioSuffixes: Set<String> = [
        "mp3", "aac", "ogg",
        "wav", "flac", "ape", "alac", "wv",
        "wma", "rm", "m4a", "dts", "dsf", "dff"
    ]
    
    static func scanFilterAndConvertToAudios(_ directoryURL: URL) -> [Audio]? {
        // 1 扫描得到文件夹中的全部文件
        guard let allFiles = scanDirectory(directoryURL) else { return nil }
        // 2 过滤音乐文件（判断文件的扩展名方式）
        let audioFiles = filterAudioFiles(allFiles)
        // 3 将文件构造转化成对象
        return convertToAudioObjects(audioFiles)
    }
    
    static func scanDirectory(_ directoryURL: URL) -> [URL]? {
        do {
            var allFiles: [URL] = []
            // 获取目录中的所有文件和文件夹
            let contents = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
            
            for itemURL in contents {
                // 检查是否是文件夹
                var isDirectory: ObjCBool = false
                if FileManager.default.fileExists(atPath: itemURL.path, isDirectory: &isDirectory) {
                    // 如果是文件夹，则递归扫描
                    if isDirectory.boolValue {
                        if let subFiles = scanDirectory(itemURL) {
                            allFiles.append(contentsOf: subFiles)
                        }
                    } else {
                        // 如果是文件，则加入文件列表
                        allFiles.append(itemURL)
                    }
                }
            }
            return allFiles
        } catch {
            print("无法访问目录：\(directoryURL.path)")
            return nil
        }
    }
    
    static func filterAudioFiles(_ files: [URL]) -> [URL] {
        return files.filter { isAudio($0.pathExtension) }
    }
    
    // 判断是否为音频文件
    static func isAudio(_ fileExtension: String) -> Bool {
        if fileExtension.isEmpty { return false }
        let isAudio =  isSuffixesEnd(audioSuffixes, filenameSuffix: fileExtension.lowercased())
        print("文件扩展名: \(fileExtension)  isAudio: \(isAudio) ")
        return isAudio
        
    }
    
    // 判断文件扩展名是否在音频文件扩展名集合中
    static func isSuffixesEnd(_ suffixes: Set<String>, filenameSuffix: String) -> Bool {
        if suffixes.isEmpty {
            fatalError("Set<String>suffixes not allow blank")
        }
        if filenameSuffix.isEmpty {
            return false
        }
        // 判断
        return suffixes.contains(filenameSuffix.lowercased())
    }
    
    static func convertToAudioObjects(_ urls: [URL]) -> [Audio] {
        // 使用 map 函数遍历文件 URL 数组，并调用 processMusicFile 方法为每个文件创建填充好字段的 Audio 对象
        return urls.map { url in
            readAudioFileToAudio(url: url)
        }
    }
    
    //用 TagLib_c 来解析音乐文件，构造出 Audio 对象
    static func readAudioFileToAudio(url: URL) -> Audio {
//        // 使用 TagLib 打开音乐文件
//        let file = taglib_file_new(cFilePath)
//        if let tag = taglib_file_tag(file){
//            // 读取到音乐文件的标签后将 C 读取到的结构体转换为 Swift 结构体（获取其他信息并相应更新 Audio 对象的其他字段）
//            let audio = Audio(id: String(cString: tag.id),
//                              filename: String(cString: tag.filename),
//                              fileExtension: String(cString: tag.fileExtension),
//                              path: String(cString: tag.path),
//                              duration: String(cString: tag.duration),
//                              fileSize: String(cString: tag.fileSize),
//                              title: String(cString: tag.title),
//                              artist: String(cString: tag.artist),
//                              composer: String(cString: tag.composer),
//                              album: String(cString: tag.album),
//                              albumImage: String(cString: tag.albumImage),
//                              albumArtist: String(cString: tag.albumArtist),
//                              genre: String(cString: tag.genre),
//                              trackNumber: String(cString: tag.trackNumber),
//                              discNumber: String(cString: tag.discNumber),
//                              comment: String(cString: tag.comment),
//                              year: String(cString: tag.year),
//                              label: String(cString: tag.label),
//                              bitRate: String(cString: tag.bitRate),
//                              sampleRate: String(cString: tag.sampleRate),
//                              tagVersion: String(cString: tag.tagVersion),
//                              channels: String(cString: tag.channels))
//        }
//        
//        // 清理工作 关闭音乐文件
//        taglib_file_free(file)
//        
//        // 释放 C 结构体指针内存
//        free(tag)
//        return audio
        
        return Audio(id: UUID().uuidString,
                        filename: url.lastPathComponent,
                        fileExtension: url.pathExtension,
                        path: url.path,
                        duration: "", // You can fill this with the actual duration
                        fileSize: "", // You can fill this with the actual file size
                        title: url.lastPathComponent, // You can fill this with the actual title
                        artist: "", // You can fill this with the actual artist
                        composer: "", // You can fill this with the actual composer
                        album: "", // You can fill this with the actual album
                        albumImage: "", // You can fill this with the actual album image
                        albumArtist: "", // You can fill this with the actual album artist
                        genre: "", // You can fill this with the actual genre
                        trackNumber: "", // You can fill this with the actual track number
                        discNumber: "", // You can fill this with the actual disc number
                        comment: "", // You can fill this with the actual comment
                        year: "", // You can fill this with the actual year
                        label: "", // You can fill this with the actual label
                        bitRate: "", // You can fill this with the actual bit rate
                        sampleRate: "", // You can fill this with the actual sample rate
                        tagVersion: "", // You can fill this with the actual tag version
                        channels: "")
    }
    
}
