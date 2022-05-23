class Role < ActiveRecord::Base
    has_many :auditions

    def actors 
        # returns an array of names from the actors associated with this role
        self.auditions.pluck(:actor)
        
        #OR
        # self.auditions.map do |audition|
        #     audition.actor
        # end
    end

    def locations
        #returns an array of locations from the auditions associated with this role
        self.auditions.pluck(:location)
       
        #OR
        #self.auditions.map(&: location)
        #^ this is the shorthand for map
    end

    def lead
        #returns the first instance of the audition that was hired for this role 
        #or returns a string 'no actor has been hired for this role'
        got_hired = self.auditions.find(&:hired)
        #OR
        #got_hired = self.Audition.find_by(hired: true)
        if (got_hired)
            got_hired
        else
            "no actor has been hired for this role"
        end
    end

    def understudy
        #returns the second instance of the audition that was hired for this role 
        #or returns a string 'no actor has been hired for understudy for this role'
        filtered_auditions = self.auditions.filter do |audition|
            audition.hired
        end
        if (filtered_auditions.length > 1)
            filtered_auditions.second
        else
            "no actor has been hired for understudy for this role"
        end
    end
end