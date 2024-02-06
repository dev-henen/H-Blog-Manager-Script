<?php

    class Medias {
        private $connection;
        public function __construct($connection) {
            $this->connection = $connection;
        }

        public function upload_media($media) {

            if(!empty($media)) {
                    
                $upload_file = new file_upload\Upload($media);
                $upload_tmp_dir = "uploads/tmp/";
                $image_upload_location = "uploads/";
                $file_url = $file_type = null;
                $uploadOk = true;
                if(!file_exists($upload_tmp_dir)) mkdir($upload_tmp_dir);
                $upload_file->set_folder($upload_tmp_dir);

                if($upload_file->is_image()) {

                    $file_type = 'image';
                    if($upload_file->permit(["png", "jpg", "gif", "jpeg"])){
                        if(!$upload_file->isExisting()){
                            if($upload_file->maxFileSize(10000000)) $uploadOk = false; // 10MB
                            if($uploadOk === true && !$upload_file->move_to_folder()) $uploadOk = false;
                            if(!$upload_file->rename(null,"JPG")){
                                $uploadOk = false;
                                $file_url = $upload_file->target_file;
                            } else { $file_url = $upload_file->auto_generated_name; }
                        }else{ $uploadOk = false;  }
                    }else{ $uploadOk = false; }
                    
                } elseif($upload_file->is_video()) {
                   
                    $file_type = 'video';
                    if($upload_file->permit(["mp4"])){
                        if(!$upload_file->isExisting()){
                            if($upload_file->maxFileSize(500000000)) $uploadOk = false; //500MB
                            if($uploadOk === true && !$upload_file->move_to_folder()) $uploadOk = false;
                            if(!$upload_file->rename(null,"mp4")){
                                $uploadOk = false;
                                $file_url = $upload_file->target_file;
                            } else { $file_url = $upload_file->auto_generated_name; }
                        }else{ $uploadOk = false;  }
                    }else{ $uploadOk = false; }

                } else {
                    $uploadOk = false;
                }

                if($uploadOk == false) {
                    http_response_code(400);
                    echo 'There was an error upload the media file, it may be corrupted or it may be an unsupported media file or the file size may be too big';
                } else {
                    $move = file_upload\move_file($file_url, $upload_tmp_dir, $image_upload_location);
                    if($move) {

                        $v1 = $v2 = null;
                        $sql = 'INSERT INTO medias(MediaType, URI) VALUES(?,?);';
                        $stmt = $this->connection->prepare($sql);
                        $stmt->bind_param('ss', $v1, $v2);
                        $v1 = $file_type;
                        $v2 = $upload_file->file_new_name;
                        if($stmt->execute()) {
                            echo 'Media file uploaded';
                        } else {
                            @unlink($file_url);
                            http_response_code(400);
                            echo 'Something went wrong uploading the file';
                        }
                        
                        
                    } else {
                        @unlink($upload_tmp_dir);
                        http_response_code(500);
                        echo 'Oops! Something went wrong uploading your file';
                    }

                }


            } else {
                http_response_code(400);
                echo 'Wrong media file';
            }

        }


        public function load_medias($type, int $offset = 0): array {

            settype($offset, 'integer');
            $type = preg_replace('/[^a-zA-Z0-9]/','', $type);
            $limit = 50;
            if($offset < 0) {
                $offset = 0;
            }
            $sql = sprintf('SELECT * FROM medias WHERE MediaType="%s" ORDER BY ID DESC LIMIT %d, %d;', $type, $offset, $limit);
            $result = $this->connection->query($sql);
            if($result->num_rows > 0) {

                return $result->fetch_all(MYSQLI_ASSOC);

            }

            return [];

        }

		public function delete_media(int $media_id): bool {

			settype($media_id, 'integer');
			$sql = sprintf('SELECT URI FROM medias WHERE ID=%d', $media_id);
			$result = $this->connection->query($sql);
			if($result->num_rows > 0) {

				$row = $result->fetch_assoc();

				$sql = sprintf('DELETE FROM medias WHERE ID=%d', $media_id);
				if($this->connection->query($sql)) {
	
					unlink('uploads/' . $row['URI']);
	
					return true;
				}

			}

			return false;
		}
    }