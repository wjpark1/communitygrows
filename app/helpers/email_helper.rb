module EmailHelper
    def send_doccom_email(committee, title)
        User.all.each do |user|
            if current_user.admin?
                NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
            elsif (committee == "internal" and user.internal?) or (committee == "external" and user.external?) or (committee == "executive" and user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.new_document_email(user, Document.find_by_title(title)).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.new_document_email(user, Document.find_by_title(title)).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.new_document_email(user, Document.find_by_title(title)).deliver
                end
            end
        end
    end

    def send_doccom_update_email(committee, title)
        User.all.each do |user|
            if current_user.admin?
                NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
            elsif (committee == "internal" and user.internal?) or (committee == "external" and user.external?) or (committee == "executive" and user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.document_update_email(user, Document.find_by_title(title)).deliver
                end
            end
        end
    end
    def send_doc_email(file)
        User.all.each do |user|
            # NotificationMailer.document_update_email(user, Document.find_by_title(@title)).deliver

            if user.digest_pref == "daily"
                NotificationMailer.new_document_email(user, file).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
            elsif user.digest_pref == "weekly"
                NotificationMailer.new_document_email(user, file).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
            else
                NotificationMailer.new_document_email(user, file).deliver
            end
        end
    end

    def send_doc_email_update(file)
        User.all.each do |user|
            if user.digest_pref == "daily"
                NotificationMailer.document_update_email(user, file).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
            elsif user.digest_pref == "weekly"
                NotificationMailer.document_update_email(user, file).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
            else
                NotificationMailer.document_update_email(user, file).deliver
            end
        end
    end 

    def send_announcement_email(committee, title)
        User.all.each do |user|
            if current_user.admin?
                NotificationMailer.announcement_email(user, Announcement.find_by_title(title)).deliver
            elsif (committee == "internal" and user.internal?) or (committee == "external" and user.external?) or (committee == "executive" and user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.announcement_email(user, Announcement.find_by_title(title)).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.announcement_email(user, Announcement.find_by_title(title)).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.announcement_email(user, Announcement.find_by_title(title)).deliver
                end
            end
        end
    end

    def send_announcement_update_email(committee, title)
        User.all.each do |user|
            if current_user.admin?
                NotificationMailer.announcement_update_email(user, Announcement.find_by_title(title)).deliver
            elsif (committee == "internal" and user.internal?) or (committee == "external" and user.external?) or (committee == "executive" and user.executive?)
                if user.digest_pref == "daily"
                    NotificationMailer.announcement_update_email(user, Announcement.find_by_title(title)).deliver_later!(wait_until: (Time.now.tomorrow.noon - Time.now).seconds.from_now)
                elsif user.digest_pref == "weekly"
                    NotificationMailer.announcement_update_email(user, Announcement.find_by_title(title)).deliver_later!(wait_until: (Time.now.next_week.noon - Time.now).seconds.from_now)
                else
                    NotificationMailer.announcement_update_email(user, Announcement.find_by_title(title)).deliver
                end
            end
        end
    end


end
