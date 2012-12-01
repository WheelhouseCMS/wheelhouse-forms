module Forms::Fields
  class StatesDropdown < Field
    property :label, String, :default => "State", :required => true
    property :country, String, :required => true

    self.renderer = Forms::SelectFieldRenderer

    def options
      STATES[country]
    end

    STATES = {
      "US" => [
          [ "Alabama", "AL" ], 
          [ "Alaska", "AK" ], 
          [ "Arizona", "AZ" ], 
          [ "Arkansas", "AR" ], 
          [ "California", "CA" ], 
          [ "Colorado", "CO" ], 
          [ "Connecticut", "CT" ], 
          [ "Delaware", "DE" ], 
          [ "District Of Columbia", "DC" ], 
          [ "Florida", "FL" ], 
          [ "Georgia", "GA" ], 
          [ "Hawaii", "HI" ], 
          [ "Idaho", "ID" ], 
          [ "Illinois", "IL" ], 
          [ "Indiana", "IN" ], 
          [ "Iowa", "IA" ], 
          [ "Kansas", "KS" ], 
          [ "Kentucky", "KY" ], 
          [ "Louisiana", "LA" ], 
          [ "Maine", "ME" ], 
          [ "Maryland", "MD" ], 
          [ "Massachusetts", "MA" ], 
          [ "Michigan", "MI" ], 
          [ "Minnesota", "MN" ], 
          [ "Mississippi", "MS" ], 
          [ "Missouri", "MO" ], 
          [ "Montana", "MT" ], 
          [ "Nebraska", "NE" ], 
          [ "Nevada", "NV" ], 
          [ "New Hampshire", "NH" ], 
          [ "New Jersey", "NJ" ], 
          [ "New Mexico", "NM" ], 
          [ "New York", "NY" ], 
          [ "North Carolina", "NC" ], 
          [ "North Dakota", "ND" ], 
          [ "Ohio", "OH" ], 
          [ "Oklahoma", "OK" ], 
          [ "Oregon", "OR" ], 
          [ "Pennsylvania", "PA" ], 
          [ "Rhode Island", "RI" ], 
          [ "South Carolina", "SC" ], 
          [ "South Dakota", "SD" ], 
          [ "Tennessee", "TN" ], 
          [ "Texas", "TX" ], 
          [ "Utah", "UT" ], 
          [ "Vermont", "VT" ], 
          [ "Virginia", "VA" ], 
          [ "Washington", "WA" ], 
          [ "West Virginia", "WV" ], 
          [ "Wisconsin", "WI" ], 
          [ "Wyoming", "WY" ]
        ],
    
      "Australia" => [
          [ "Australian Capital Territory", "ACT" ],
          [ "New South Wales", "NSW" ],
          [ "Northern Territory", "NT" ],
          [ "South Australia", "SA" ],
          [ "Tasmania", "TAS" ],
          [ "Victoria", "VIC" ],
          [ "Western Australia", "WA" ],
          [ "Queensland", "QLD" ]
        ]
    }
  end
end
