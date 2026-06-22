table 50007 "Form Header"
{
    DataCaptionFields = "No.", "Equipment No.", "Equipment Name";
    Permissions = tabledata "Fixed Asset" = rm;
    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate();
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    FleetManagementSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Document Type"; Enum "Form Type")
        {
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Time; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable= true;
        }
        field(5; "Former Driver"; Code[20])
        {
            TableRelation = Employee."No." where("Employee Type" = filter('DRIVER'));
            
            trigger OnValidate()
            var
                Employee: Record Employee;
                FixedAsset: Record "Fixed Asset";
            begin
                if Rec."Former Driver" <> '' then
                    if Rec."Former Driver" = Rec."Assigned Driver" then
                        Error('Assigned driver cannot be the same as the former driver');

                if Employee.Get("Former Driver") then begin
                    "Former Driver Name" := Employee.FullName();
                   
                end else begin
                    "Former Driver Name" := '';
                end;

                if Rec."Former Driver" <> '' then begin
                    FixedAsset.Reset();
                    FixedAsset.SetRange("Responsible Employee", Rec."Former Driver");
                    FixedAsset.SetRange("Equipment Status", FixedAsset."Equipment Status"::Available);
                    if FixedAsset.FindFirst() then begin
                        Rec."Equipment No." := FixedAsset."No.";
                        Rec.Validate("Equipment No.");
                    end;
                end;
               
            end;
        }
        field(6; "Former Driver Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Assigned Driver"; Code[20])
        {
             TableRelation = Employee."No." where("Employee Type" = filter('DRIVER'), "Driver Status" = filter(Active), "License expired" = const(false),"Defensive Driving Days" = filter(>0), "Medical Fitness Days" = filter(>0));
             //TableRelation = Employee."No." where("Employee Type" = filter('DRIVER'), "Driver Status" = filter(Active), "Days to License expiry" = filter(>=0D|''), "Defensive Driving Days" = filter(>=0D|''), "Medical Fitness Days" = filter(>=0D|''));
            
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                //if Rec."Assigned Driver" <> '' then
                    if Rec."Former Driver" = Rec."Assigned Driver" then
                        Error('Assigned driver cannot be the same as the former driver');

                if Employee.Get("Assigned Driver") then begin
                    "Assigned Driver Name" := Employee.FullName();
                    //check if the assigned driver has a valid drivers license
                    Employee.TestField("License Validity End date");
                    if Employee."License Validity End date" < Today then
                        Error('The assigned driver %1 has an expired drivers license. Please assign another driver.', Employee.FullName())
                    else begin
                        Rec."License Expiry Date" := Employee."License Validity End date";
                        Rec."Driver's License" := Rec."Driver's License"::VALID;
                    end;

                    //check if the assigned driver has a valid defensive driving certificate
                    Employee.TestField("DefensiveDrive ValidEndDate");
                    if Employee."DefensiveDrive ValidEndDate" < Today then
                        Error('The assigned driver %1 has an expired defensive driving certificate. Please assign another driver.', Employee.FullName())
                    else begin
                        Rec."Defensive Driving Exp. Date" := Employee."DefensiveDrive ValidEndDate";
                        Rec."Defensive Driving Certificate" := Rec."Defensive Driving Certificate"::VALID;
                    end;

                    //check if the assigned driver has a valid medical fitness certificate
                    Employee.TestField("Fitness Validity End Date");
                    if Employee."Fitness Validity End Date" < Today then
                        Error('The assigned driver %1 has an expired medical fitness certificate. Please assign another driver.', Employee.FullName())
                    else begin
                        Rec."Medical Fitness Certificate" := Rec."Medical Fitness Certificate"::VALID;
                    end;

                end else begin
                    "Assigned Driver Name" := '';
                end;

                

            end;
        }
        field(8; "Assigned Driver Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Equipment No."; Code[20])
        {
           
            TableRelation = "Fixed Asset"."No." where("Equipment Status" = filter(Available));
            

            trigger OnValidate()
            var
                Equipment: Record "Fixed Asset";
                Employee: Record "Employee";

            begin
                if Equipment.Get("Equipment No.") then begin
                    //"Employee No." := Equipment."Responsible Employee";
                    "Equipment Name" := Equipment.Description;
                    "Equipment Serial No." := Equipment."Serial No.";
                    "Equipment Make" := Equipment."Make";
                    "Equipment Model" := Equipment."Model";
                    "Equipment RegNo" := Equipment."Registration No.";
                    "Equipment Type" := Equipment."Equipment Type";
                    "Next Service at Mileage" := Equipment."Next Service At Mileage";
                    "3RD Party Exp. Date" := Equipment."3RD Party Expiry Date";
                    "Week Start Km's" := Equipment."Vehicle Mileage";
                    "Next Service" := Equipment."Next Service At Mileage";
                    "Driver No." := Equipment."Responsible Employee";
                    if Employee.Get(Rec."Driver No.") then begin
                    Rec."Driver Name" := Employee.FullName();
                    end;
                    //"Driver Name" := Equipment."Responsible Employee Id";
                    "Odometer Reading" := Equipment."Vehicle Mileage";
                

                    // if Rec."Document Type" in [Rec."Document Type"::"Daily Assignment", Rec."Document Type"::"Incident Notification Form"] then begin
                    //     Rec.Validate("Driver No.", Equipment."Responsible Employee");
                    // end;

                    if "Driver No." <> '' then
                        if Rec."Driver No." <> Equipment."Responsible Employee" then
                            Error('This vehicle is not assigned to: %1', Rec."Driver No.");
                        
                end else begin
                    "Equipment Name" := '';
                    "Equipment Serial No." := '';
                    "Equipment Make" := '';
                    "Equipment Model" := '';
                    "Equipment RegNo" := '';
                    "Equipment Type" := '';
                    "Next Service at Mileage" := 0;
                    "3RD Party Exp. Date" := 0D;
                    // if Rec."Document Type" in [Rec."Document Type"::"Daily Assignment", Rec."Document Type"::"Incident Notification Form"] then begin
                    //     Rec.Validate("Driver No.", '');
                    // end;
                end;
            end;
            
        }
        field(10; "Equipment Name"; Text[100])
        {
            Editable = false;
        }
        field(11; "Equipment Serial No."; Text[50])
        {
            Editable = false;
        }
        field(12; "Equipment Make"; Text[50])
        {
            Editable = false;
        }
        field(13; "Equipment Model"; Text[50])
        {
            Editable = false;
        }
        field(14; "Equipment RegNo"; Text[50])
        {
            Editable = false;
        }
        field(15; "Equipment Type"; Code[20])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
           
            trigger OnValidate()
            var
                FormLine: Record "Form Line";
            begin
                if xRec."Equipment Type" <> Rec."Equipment Type" then begin
                    FormLine.SetRange("Document Type", Rec."Document Type");
                    FormLine.SetRange("Document No.", Rec."No.");
                    FormLine.SetFilter("Equipment Type", xRec."Equipment Type");
                    //FormLine.SetRange("Equipment No.", Rec."Equipment No.");
                    if FormLine.FindSet() then
                        repeat
                            FormLine.Validate("Equipment Type", Rec."Equipment Type");
                            FormLine.Modify();
                        until FormLine.Next() = 0;
                end;
            end;

            
        }
        field(16; "Any Dents"; Enum "Any Dents")
        {
           DataClassification = ToBeClassified;
        }
        field(17; "Dents Description"; Text[250])
        {

        }
        field(18; "Any Scratches"; Enum "Any Scratches")
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Scratches Description"; Text[250])
        {

        }
        field(20; "Interior Condition"; Option)
        {
            OptionMembers = GOOD,TIDY,DIRTY,CLEAN;
            OptionCaption = 'Good Enough,Tidy,Dirty,Clean';
        }
        field(21; "Interior Remarks"; Text[250])
        {

        }
        field(22; "General Mechanical Condition"; Option)
        {
            OptionMembers = " ",BAD,GOOD,"NEEDS CHECK";
            OptionCaption = ' ,Bad,Good,Needs Check';
        }
        field(23; "Mechanical Remarks"; Text[250])
        {

        }
        field(24; "Fuel Level"; Option)
        {
            OptionMembers = " ",EMPTY,"HALF-QUARTER TANK","ABOVE HALF TANK","FULL TANK";
            OptionCaption = ' ,Empty,Half-Quarter Tank,Above Half Tank,Full Tank';
        }
        field(25; "Odometer Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Next Service"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Driver's License"; Option)
        {
            OptionMembers = " ",VALID,EXPIRED,NOT_PRESENT;
            OptionCaption = ' ,Valid,Expired,Not Present';
        }
        field(28; "Defensive Driving Certificate"; Option)
        {
            OptionMembers = " ",VALID,EXPIRED,NOT_PRESENT;
            OptionCaption = ' ,Valid,Expired,Not Present';
        }
        field(29; "Medical Fitness Certificate"; Option)
        {
            OptionMembers = " ",VALID,EXPIRED,NOT_PRESENT;
            OptionCaption = ' ,Valid,Expired,Not Present';
        }
        field(30; "Posting No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(31; "No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(32; "Prepared by"; Code[100])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(33; Status; Enum "Document Status")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Approvals Entry"; Integer)
        {
            FieldClass = FlowField;
            //CalcFormula = count("Approval Entry" where("Document No." = field("No."), Status = filter(open | Created)));
            CalcFormula = count("Approval Entry"
                where(
                    "Table ID" = const(50007),
                    "Document No." = field("No."),
                    Status = filter(Open | Created)));
            Editable = false;
        }
        field(35; "Current Approver"; Code[100])
        {
            FieldClass = FlowField;
           // DataClassification = ToBeClassified;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field("No.")));
            //, Status = filter(Open)));

            // CalcFormula = lookup("Approval Entry"."Approver ID"
            //     where(
            //         "Table ID" = const(50007),
            //         "Document No." = field("No."),
            //         Status = filter(Open | Created)));
            Editable = false;
          
            
        }
        field(36; "Driver Assigned"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37; "Assignment Date"; Date)
        {
            Editable = false;
        }
        field(38; "Assigned By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(39; "Client No."; Code[20])
        {
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                Customer: Record Customer;
                Contact: Record Contact;
            begin
                if Rec."Client No." <> '' then
                    if Customer.Get(Rec."Client No.") then begin
                        Rec."Client Name" := Customer.Name;
                        Rec.Address := Customer.Address;
                        Rec."Address 2" := Customer."Address 2";
                        Rec."Contact Person Name" := Customer.Contact;
                        Rec.Currency := Customer."Currency Code";
                        Contact.Reset();
                        Contact.SetRange("No.", Customer."Primary Contact No.");
                        if Contact.FindFirst() then begin
                            Rec."Contact Person Contact" := Contact."Phone No.";
                            Rec."Contact Person Email" := Contact."E-Mail";
                        end;
                        Rec.Modify();
                    end;
            end;
        }
        field(40; "Client Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(41; Address; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Address 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(43; Quantity; Decimal)
        {
            trigger OnValidate()
            begin
                Rec.TestField("Equipment Type");
            end;
        }
        field(44; "Job Location"; Code[50])
        {
            trigger OnValidate()
            begin
                Rec.TestField(Quantity);
            end;
        }
        field(45; "Job Start Date"; Date)
        {
            trigger OnValidate()
            begin
                Rec.TestField(Quantity);
                Rec.TestField("Job Location");

                if (Rec."Job Start Date" <> 0D) AND (Rec."Job End Date" <> 0D) then
                    if Rec."Job Start Date" > Rec."Job End Date" then
                        Error('Start Date Can not be greater than the End Date.');
            end;
        }
        field(46; "Job End Date"; Date)
        {
            trigger OnValidate()
             var
                DateDiff: Integer;
            begin
                Rec.TestField(Quantity);
                Rec.TestField("Job Location");

                if (Rec."Job Start Date" <> 0D) AND (Rec."Job End Date" <> 0D) then
                    if Rec."Job End Date" < rec."Job Start Date" then
                        Error('End Date can not be less than the Start Date.');
                if Rec."Job End Date" >= Rec."Job Start Date" then begin
                                DateDiff := Rec."Job End Date" - Rec."Job Start Date";
                                Rec."Hire Days" := DateDiff + 1;
                end;
                
            end;
            
        }
        field(47; "Client Category"; Option)
        {
            OptionMembers = " ",INTERNAL,EXTERNAL;
            Editable = false;
        }
        field(48; "Contact Person Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Contact Person Contact"; Text[15])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(50; "Hourly Rate"; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec."Hourly Rate" then begin
                    Rec.TestField(Daily, false);
                    Rec.TestField(Monthly, false);
                    Rec.TestField("Per Trip", false);
                end;
            end;
        }
        field(51; Daily; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec.Daily then begin
                    Rec.TestField("Hourly Rate", false);
                    Rec.TestField(Monthly, false);
                    Rec.TestField("Per Trip", false);
                end;
            end;
        }
        field(52; Monthly; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec.Monthly then begin
                    Rec.TestField(Daily, false);
                    Rec.TestField("Hourly Rate", false);
                    Rec.TestField("Per Trip", false);
                end;
            end;
        }
        field(53; "Dry Hire"; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec."Dry Hire" then begin
                    Rec.TestField("Wet Hire", false);
                    Rec.TestField("Per Trip", false);
                end;
            end;
        }
        field(54; "Wet Hire"; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec."Wet Hire" then begin
                    Rec.TestField("Dry Hire", false);
                    Rec.TestField("Per Trip", false);
                end;
            end;
        }
        field(55; "Per Trip"; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec."Per Trip" then begin
                    Rec.TestField(Daily, false);
                    Rec.TestField("Hourly Rate", false);
                    Rec.TestField(Monthly, false);
                    Rec.TestField("Dry Hire", false);
                    Rec.TestField("Wet Hire", false);
                end;
            end;
        }
        field(56; Other; Text[100])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(57; Currency; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(58; "Hire Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Payment Terms"; Code[20])
        {
            TableRelation = "Payment Terms".Code;
        }
        field(60; "Sales Invoice/Order No."; Code[20])
        {
            TableRelation = "Sales Header"."No.";
        }
        field(61; "Line To Invoice Type"; Enum "Maintenance Line Type")
        {
            trigger OnValidate()
            begin
                Rec.TestField(Status, Rec.Status::Released);
                Rec.TestField(Converted, false);
            end;
        }
        field(62; "Line To Invoice No."; Code[20])
        {
            TableRelation = if ("Line To Invoice Type" = const(" ")) "Standard Text"
            else
            if ("Line To Invoice Type" = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else
            if ("Line To Invoice Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Line To Invoice Type" = const(Item)) Item where(Blocked = const(false))
            else
            if ("Line To Invoice Type" = const(Resource)) Resource;

            trigger OnValidate()
            begin
                Rec.TestField(Converted, false);
                Rec.TestField(Status, Rec.Status::Released);
                case "Line To Invoice Type" of
                    "Line To Invoice Type"::" ":
                        CopyFromStandardText();
                    "Line To Invoice Type"::"G/L Account":
                        CopyFromGLAccount();
                    "Line To Invoice Type"::Item:
                        CopyFromItem();
                    "Line To Invoice Type"::Resource:
                        CopyFromResource();
                    "Line To Invoice Type"::"Fixed Asset":
                        CopyFromFixedAsset();
                end;
            end;
        }
        field(63; Description; Text[100])
        {
            Editable = false;
        }
        field(64; "Contact Person Email"; Text[50])
        {
            ExtendedDatatype = EMail;
        }
        field(65; Authorized; Boolean)
        {
            Editable = false;
        }
        field(67; "Authorized By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(68; "Authorized At"; Date)
        {
            Editable = false;
        }
        field(69; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
            trigger OnValidate()
            begin
                Rec.TestField(Converted, false);
                Rec.TestField(Status, Rec.Status::Released);
            end;
        }
        field(71; Converted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(72; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(73; "Driver No."; Code[20])
        {
            TableRelation = Employee."No." where("Employee Type" = filter('DRIVER'), "Driver Status" = filter(Active), "License expired" = const(false),"Defensive Driving Days" = filter(>0), "Medical Fitness Days" = filter(>0));

            trigger OnValidate()
            var
                Employee: Record Employee;
                FixedAsset: Record "Fixed Asset";
            begin
                if Employee.Get(Rec."Driver No.") then begin
                    Rec."Driver Name" := Employee.FullName();
                    Rec."License Expiry Date" := Employee."License Validity End date";
                    Rec."Defensive Driving Exp. Date" := Employee."DefensiveDrive ValidEndDate";
                    Rec."Driver's Contact" := Employee."Phone No.";
                end
                else begin
                    Rec."Driver Name" := '';
                    Rec."License Expiry Date" := 0D;
                    Rec."Defensive Driving Exp. Date" := 0D;
                end;

                    if Rec."Driver No." <> '' then begin
                        FixedAsset.Reset();
                        FixedAsset.SetRange("Responsible Employee", Rec."Driver No.");
                        FixedAsset.SetRange("Equipment Status", FixedAsset."Equipment Status"::Available);
                        if FixedAsset.FindFirst() then begin
                            Rec."Equipment No." := FixedAsset."No.";
                            Rec.Validate("Equipment No.");
                        end;
                    end else begin
                        Rec."Equipment No." := '';
                        Rec.Validate("Equipment No.");
                    end;

                Rec.Modify();
            end;
        }
        field(74; "Driver Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(75; "Near Miss"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "First Aid Case;"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Medical Treatment Case;"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Restricted Work Case/Injury;"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Lost Time Injury"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(80; Fatality; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Motor Vehicle Crash"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Property Damage/Material Loss"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Environmental Spill"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(84; Fire; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Security Incident"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Vector/Vermin Infestation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Serious Illness"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(88; "Disease Outbreak"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(89; OtherOptions; Text[500])
        {
            Caption = 'Other';
        }
        field(90; "Site Specific Location"; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(91; "Title of Incident"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(92; "Date and Time of Incident"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(93; "Reported Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(94; "Parties Involved"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Was anyone injured?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(96; "Was there any property damage?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(97; WasThereAnyEnvironmentalDamage; Boolean)
        {
            Caption = 'Was there any environmental damage?';
        }
        field(98; "What is the incident severity?"; Boolean)
        {
            Caption = 'What is the incident severity?';
        }
        field(99; IncidentInvestigationRequired; Boolean)
        {
            Caption = 'Incident investigation required?';
        }
        field(100; "AnyOne Injured Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(101; "Property Damaged Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Environment Damage Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Severity Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(104; "Investigation Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(105; Designation; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(106; "First Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Last Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(108; "Shift Duration"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(109; Contact; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Residential Address"; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(111; "SuperVisor No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get(Rec."SuperVisor No.") then begin
                    Rec."Supervisor Name" := Employee.FullName();
                    Rec.Modify();
                end;
            end;
        }
        field(112; "Supervisor Name"; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(113; RelationshipToTheCompany; Code[100])
        {
            Caption = 'Relationship To The Company';
        }
        field(114; "Description Of Injury/Illness"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Body Location"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(116; "Treatment Given"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(117; Referral; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(118; "Notifier Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(119; "Notifier Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Notifier Work Location"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(121; "Notifier Contact"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(122; "Notifier Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(123; "Notifier Site Manager"; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(124; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get(Rec."Employee No.") then begin
                    Rec."First Name" := Employee."First Name";
                    Rec."Last Name" := Employee."Last Name";
                    Rec.Designation := Employee."Job Title";
                    Rec.Modify();
                end;
            end;
        }

        field(125; "Notifier No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get(Rec."Notifier No.") then begin
                    Rec."Notifier Name" := Employee.FullName();
                    Rec."Notifier Email" := Employee."Company E-Mail";
                    Rec."Notifier Contact" := Employee."Phone No.";
                    Rec."Notifier Title" := Employee."Job Title";
                    Rec.Modify();
                end;
            end;
        }
        field(126; "Week Start Km's"; Decimal)
        {
            trigger OnValidate()
            begin
                Rec.TestField("Inspection Type");
                if "Week Start Km's" <> 0 then
                    if "Week End Km's" <> 0 then
                        if "Week End Km's" < "Week Start Km's" then
                            Error('Week Start Kms can not be greater than the week End KMs');

            end;
        }
        field(127; "Week End Km's"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestField("Inspection Type");
                if "Week End Km's" <> 0 then
                    if "Week Start Km's" > "Week End Km's" then
                        Error('Week Start Kms can not be greater than the week End KMs');
            end;
        }
        field(128; Department; Code[150])
        {
            TableRelation = "General value".Code where(Type = const(Department));
        }
        field(129; "Crew Location"; Code[150])
        {
            TableRelation = "General value".Code where(Type = const(Location));
        }
        field(130; "Week Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(131; "License Expiry Date"; Date)
        {
            Caption = 'Valid Drivers License (exp. Date)';
        }
        field(132; "Next Service at Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(133; "Defensive Driving Exp. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(134; "3RD Party Exp. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        //Journey Management Plan
        field(135; "Site Name"; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location."Code";
            trigger OnValidate()
            var
                Location: Record Location;
            begin
                //if Rec."JMP Requester No." <> '' then
                if Location.Get(Rec."Site Name") then begin
                    Rec."Site Name" := Location.Name;
                    Rec.Modify();
                end;
            end;
        }
        field(136; "Validity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(137; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(138; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(139; "JMP Requester No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Rec."JMP Requester No." <> '' then
                    if Employee.Get(Rec."JMP Requester No.") then begin
                        Rec."JMP Requester Name" := Employee.FullName();
                        Rec.Modify();
                    end;
            end;
        }
        field(140; "JMP Requester Name"; Text[150])
        {
            Editable = false;
        }
        field(141; "JMP User No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Rec."JMP User No." <> '' then
                    if Employee.Get(Rec."JMP User No.") then begin
                        Rec."JMP User Name" := Employee.FullName();
                        Rec.Modify();
                    end;
            end;
        }
        field(142; "JMP User Name"; Text[200])
        {
            Editable = false;
        }
        field(143; "Point Of Departure"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(144; "Departure Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(145; Destination; Code[150])
        {
            DataClassification = ToBeClassified;
        }
        field(146; "Planned Date of Return"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(147; Distance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(148; "Black Top Road"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(149; "Murram Road"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(150; "Stop Over"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(151; "Personnel Transport"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(152; "Material Transport"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(153; "Food Delivery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(154; "Driver's Contact"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(155; "Last Vehicle Inspection"; Date)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin

            // end;
        }
        field(156; "Number Of Passengers"; Integer)
        {
            Caption = 'Number Of Passengers (incl. Driver)';
        }
        field(157; "Number Of Ugandan Citizens"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(158; "Number of Resident Foreigners"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(159; "NumberOf NonResidentForeigners"; Integer)
        {
            Caption = 'Number Of Non-Resident Foreigners';
        }
        field(160; "Risk Assessment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(161; "HSE Induction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(162; "Risk Level"; Option)
        {
            OptionMembers = " ",Low,Medium,High;
        }
        field(163; "Journey Started"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(164; "Inspection Type"; Option)
        {
            OptionMembers = " ","Pre-Trip","Post-Trip";
        }
        field(165; "Set out"; Boolean)
        {
            Editable = false;
        }
        field(166; "Touch Down"; Boolean)
        {
            Editable = false;
        }
        field(167; "Set out By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(168; "Touch Down By"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(169; "Set Out Date"; Date)
        {
            Editable = false;
        }
        field(170; "Touch Down Date"; Date)
        {
            Editable = false;
        }
        field(171; Validity; Option)
        {
            OptionMembers = " ",Daily,Weekly,Monthly,Trip;
        }
        field(172; "Journey Ended"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(173; Days; Integer)
        {
            
            DataClassification = ToBeClassified;
            //Editable = false;
            // trigger OnValidate()
            // begin
            //     if Rec."From Date" <> 0D then 
            //       if Rec."To Date" <> 0D then begin  
            //         Rec.Days:= Abs(Rec."From Date" - Rec."To Date");
            //         Rec.Modify();      
                
            //     end;
            // end;
        }
        field(174; "Hours"; Integer)
        {
            DataClassification = ToBeClassified;
            //Editable = false ;  
           
        }
        field(175;"Client Complaint"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(176;"Complaint No."; Code[20])
        {
            //DataClassification = ToBeClassified;
            trigger OnValidate();
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    FleetManagementSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;

        }
        field(177; "State"; Enum "State")
        {
            DataClassification = ToBeClassified;
            //Editable = true;

        }
        field(178; "Incident Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = true;
        }
        field(179; "Complaint Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = true;
        }
        field(180; "TermsofHire"; Text[250])
        {
            DataClassification = ToBeClassified;
            //Editable = true;
        }
        field(181; "EstimatedHireCost"; Decimal)
        {
            DataClassification = ToBeClassified;
            //Editable = true;
        }
        field(182; "Hire Days"; Integer)
        {
            DataClassification = ToBeClassified;
            

        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(key2; "Client Category") { }

        key(Key3;"Equipment No."){}
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FleetManagementSetup: Record "Fleet Management Setup";
        ANFSetup: Record "Fleet Management Setup";
        Text003: Label 'You cannot rename a %1.';
        JobExecutedCount: Integer;
        IncidenceCount: Integer;

    trigger OnInsert()
    begin
        Date := Today;
        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", Date, "No.", "No. Series");
        END;

        InitRecord;
        Rec."Prepared by" := UserId;
        if Rec."Document Type" = Rec."Document Type"::"Internal Hire" then
            Rec."Client Category" := Rec."Client Category"::INTERNAL
        else if Rec."Document Type" = Rec."Document Type"::"External Hire" then
            Rec."Client Category" := Rec."Client Category"::EXTERNAL
        else
            Rec."Client Category" := Rec."Client Category"::" ";
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin
        ERROR(Text003, TABLECAPTION);
    end;

    /// <summary>
    /// Description for AssistEdit.
    /// </summary>
    /// <param name="FormHeader">Parameter of type Record "ADT Requisition Header".</param>
    /// <returns>Return variable "Boolean".</returns>
    procedure AssistEdit(FormHeader: Record "Form Header"): Boolean;
    begin
        ANFSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, FormHeader."No. Series", "No. Series") THEN BEGIN
            FleetManagementSetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    /// <summary>
    /// Description for TestNoSeries.
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    local procedure TestNoSeries(): Boolean;
    begin
        FleetManagementSetup.GET;
        CASE "Document Type" OF
            "Document Type"::"Equipment Hand Over":
                FleetManagementSetup.TESTFIELD("Assignment No.");
            "Document Type"::"Internal Hire":
                FleetManagementSetup.TESTFIELD("Internal Hire Nos.");
            "Document Type"::"External Hire":
                FleetManagementSetup.TESTFIELD("External Hire Nos.");
            "Document Type"::"Daily Assignment":
                FleetManagementSetup.TESTFIELD("Daily Assignment Nos.");
            "Document Type"::"Incident Notification Form":
                FleetManagementSetup.TESTFIELD("Incident Nos.");
            "Document Type"::"Vehicle Movement Log":
                FleetManagementSetup.TestField("Vehicle Movement Log Nos.");
            "Document Type"::"Equipment Inspection":
                FleetManagementSetup.TestField("Inspection Nos");
            "Document Type"::"Journey Management Plan":
                FleetManagementSetup.TestField("Journey Management Nos.");
            "Document Type"::"Routine Service Tracker":
                FleetManagementSetup.TestField("Routine Service Tracker No.");
        END;
    end;

    /// <summary>
    /// Description for GetNoSeriesCode.
    /// </summary>
    /// <returns>Return variable "Code[10]".</returns>
    local procedure GetNoSeriesCode(): Code[10];
    begin

        CASE "Document Type" OF
            "Document Type"::"Equipment Hand Over":
                exit(FleetManagementSetup."Assignment No.");
            "Document Type"::"Internal Hire":
                exit(FleetManagementSetup."Internal Hire Nos.");
            "Document Type"::"External Hire":
                exit(FleetManagementSetup."External Hire Nos.");
            "Document Type"::"Daily Assignment":
                exit(FleetManagementSetup."Daily Assignment Nos.");
            "Document Type"::"Incident Notification Form":
                exit(FleetManagementSetup."Incident Nos.");
            "Document Type"::"Vehicle Movement Log":
                exit(FleetManagementSetup."Vehicle Movement Log Nos.");
            "Document Type"::"Equipment Inspection":
                exit(FleetManagementSetup."Inspection Nos");
            "Document Type"::"Journey Management Plan":
                exit(FleetManagementSetup."Journey Management Nos.");
            "Document Type"::"Routine Service Tracker":
                exit(FleetManagementSetup."Routine Service Tracker No.");
        END;
    end;

    procedure InitRecord();
    begin
        ANFSetup.GET;
        CASE "Document Type" OF
            "Document Type"::"Equipment Hand Over":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (ANFSetup."Assignment No." = ANFSetup."Assignment No.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Assignment No.");

                    "Prepared by" := UserId;
                END;
            "Document Type"::"Internal Hire":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (ANFSetup."Internal Hire Nos." = ANFSetup."Internal Hire Nos.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Internal Hire Nos.");

                    "Prepared by" := UserId;
                END;
            "Document Type"::"External Hire":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (ANFSetup."External Hire Nos." = ANFSetup."External Hire Nos.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."External Hire Nos.");

                    "Prepared by" := UserId;
                END;
            "Document Type"::"Daily Assignment":
                BEGIN
                    IF ("No. Series" <> '') AND (ANFSetup."Daily Assignment Nos." = ANFSetup."Daily Assignment Nos.")
                THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Daily Assignment Nos.");

                    "Prepared by" := UserId;
                END;
            "Document Type"::"Incident Notification Form":
                begin
                    IF ("No. Series" <> '') AND (ANFSetup."Incident Nos." = ANFSetup."Incident Nos.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Incident Nos.");

                    "Prepared by" := UserId;
                end;
            "Document Type"::"Vehicle Movement Log":
                begin
                    IF ("No. Series" <> '') AND (ANFSetup."Vehicle Movement Log Nos." = ANFSetup."Vehicle Movement Log Nos.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Vehicle Movement Log Nos.");

                    "Prepared by" := UserId;
                end;
            "Document Type"::"Equipment Inspection":
                begin
                    IF ("No. Series" <> '') AND (ANFSetup."Inspection Nos" = ANFSetup."Inspection Nos")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Inspection Nos");

                    "Prepared by" := UserId;
                end;
            "Document Type"::"Journey Management Plan":
                begin
                    IF ("No. Series" <> '') AND (ANFSetup."Journey Management Nos." = ANFSetup."Journey Management Nos.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Journey Management Nos.");

                    "Prepared by" := UserId;
                end;
            "Document Type"::"Routine Service Tracker":
                begin
                    IF ("No. Series" <> '') AND (ANFSetup."Routine Service Tracker No." = ANFSetup."Routine Service Tracker No.")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Routine Service Tracker No.");

                    "Prepared by" := UserId;
                end;
        END;

        Date := WorkDate();

        if Date = 0D then
            Date := WorkDate();
    end;

    procedure CreateFormLines()
    var
        i: Integer;
        FormLine: Record "Form Line";
        FormLine1: Record "Form Line";
        LineNo: Integer;
        ItemsArray: array[9] of Text;
    begin
        if Rec."Document Type" = Rec."Document Type"::"Equipment Hand Over" then begin
            ItemsArray[1] := 'SPARE TYRE';
            ItemsArray[2] := 'CAR MANUAL';
            ItemsArray[3] := 'JACK KIT';
            ItemsArray[4] := 'SPANNER';
            ItemsArray[5] := 'FIRE EXTINGUISHER';
            ItemsArray[6] := 'REFLECTOR TRIANGLES';
            ItemsArray[7] := 'FIRST AID KIT';
            ItemsArray[8] := 'TIRE LIVER';
            ItemsArray[9] := 'OTHERS';
            LineNo := 1000;

            FormLine1.Reset();
            FormLine1.SetRange("Document Type", FormLine1."Document Type"::"Equipment Hand Over");
            FormLine1.SetRange("Document No.", Rec."No.");
            if FormLine1.FindSet() then
                FormLine1.DeleteAll();

            for i := 1 to ArrayLen(ItemsArray) do begin
                LineNo := LineNo + i;
                FormLine.Init();
                FormLine."Document Type" := FormLine."Document Type"::"Equipment Hand Over";
                FormLine."Document No." := Rec."No.";
                FormLine."Line No." := LineNo;
                FormLine."Items Present" := ItemsArray[i];
                FormLine.Insert();
            end;
        end;
    end;

    //================================Approval=========================================

    procedure PerformManualReopen(VAR NFLFormHeader: Record "Form Header")
    var
        UserSetUp: Record "User Setup";
        VoucherAdmin: Boolean;
    begin
        VoucherAdmin := false;

        UserSetUp.Reset();
        UserSetUp.SetRange(UserSetUp."User ID", UserId);
        UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
        if UserSetUp.FindFirst() then begin
            VoucherAdmin := true;
        end;
        if (VoucherAdmin = true) then begin
            IF NFLFormHeader.Status = NFLFormHeader.Status::"Pending Approval" THEN
                ERROR('You Can not open a document Pending Approval');
            Reopen(NFLFormHeader);
        end else begin
            Error('Your not allowed to perform this Operation, Document can only be opened by Voucher Admin');
        end;
    end;

    procedure Reopen(VAR NFLFormHeader: Record "Form Header")
    begin
        WITH NFLFormHeader DO BEGIN
            IF Status = Status::Open THEN
                EXIT;
            Status := Status::Open;
            MODIFY(TRUE);
            Message('The Document has been Reopened Successfully');
        END;
    end;

    procedure ReleaseTheApprovedDoc()
    var
        NvText: Label 'The approval Request has been Approved';
        FormHeader: Record "Form Header";
    begin
        CalcFields("Approvals Entry");
        if "Approvals Entry" = 0 then begin
            if Rec.Status = Rec.Status::"Pending approval" then begin
                FormHeader.Reset();
                FormHeader.SetRange("No.", Rec."No.");
                if FormHeader.FindFirst() then begin
                    FormHeader.Status := FormHeader.Status::Released;
                    FormHeader.Modify();
                end;
            end;
            Message(NvText);
        end;
    end;
    procedure RejectTheApprovedDoc()
    var
        NvText: Label 'The approval Request has been Rejected';
        FormHeader: Record "Form Header";
    begin
        CalcFields("Approvals Entry");
        if "Approvals Entry" = 0 then begin
            if Rec.Status = Rec.Status::"Pending approval" then begin
                FormHeader.Reset();
                FormHeader.SetRange("No.", Rec."No.");
                if FormHeader.FindFirst() then begin
                    FormHeader.Status := FormHeader.Status::Rejected;
                    FormHeader.Modify();
                end;
            end;
            Message(NvText);
        end;
    end;

    //check he document release
    procedure CheckDocumentRelease(var FormHeader: Record "Form Header")
    var
        ApprovalEntries: Record "Approval Entry";
        NotReleased: Boolean;
        countNumber: Integer;
    begin
        NotReleased := false;
        countNumber := 0;

        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Document No.", FormHeader."No.");
        if ApprovalEntries.FindFirst() then begin
            repeat
                if (ApprovalEntries.Status = ApprovalEntries.Status::Open) or (ApprovalEntries.Status = ApprovalEntries.Status::Created) then
                    NotReleased := true;
                countNumber += 1;
            until ApprovalEntries.Next() = 0;
        end;

        if (countNumber > 0) and (NotReleased = false) then
            Rec.SendReleaseEmail(FormHeader);
    end;


    procedure SendingCancelApprovalEmail(FormHeader: Record "Form Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
    begin

    end;

    procedure SendRequisitionApprovedEmail(FormHeader: Record "Form Header")
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", FormHeader."No.");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst() then begin
            SendEmailToVoucherOwner(FormHeader, ApprovalEntry);
            SendEmailToVoucherApprover(FormHeader, ApprovalEntry);
        end;
    end;

    procedure SendEmailToVoucherOwner(FormHeader: Record "Form Header"; ApprovalEntry: Record "Approval Entry")
    var
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
    begin
        if UserSetup.Get(ApprovalEntry."Sender ID") then begin
            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Hand Over Request No. ' + ApprovalEntry."Document No." + ' is with ' + ApprovalEntry."Approver ID";
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := ApprovalEntry."Document No.";
            EmailSubject := 'Hand Over Approval in Progress ' + DocumentNo;
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure SendEmailToVoucherApprover(FormHeader: Record "Form Header"; ApprovalEntry: Record "Approval Entry")
    var
        ApprovalEmailSubject: Text[150];
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttachmentInStream: InStream;
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
    begin
        if UserSetup.Get(ApprovalEntry."Approver ID") then begin
            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>' + 'HandOver Request No. ' + ApprovalEntry."Document No." + ' is on your desk for approval ' + 'https://dynamics365.bcc.co.ug/BC230/?company=Blue%20Crane%20Communications&page=654';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := ApprovalEntry."Document No.";
            EmailSubject := 'HandOver Request ' + DocumentNo + ' Requires Your attention';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure SendReleaseEmail(FormHeader: Record "Form Header")
    var
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
    begin
        if UserSetup.Get(FormHeader."Prepared by") then begin
            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>HandOver Request No. ' + FormHeader."No." + ' has been Approved/Released.';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := FormHeader."No.";
            EmailSubject := 'HandOver Request ' + DocumentNo + ' has been approved.';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure SendRejectEmail(FormHeader: Record "Form Header")
    var
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
        RejectComment: Text[1000];
        SalesCommentLine: Record "Sales Comment Line";
    begin
        if UserSetup.Get(FormHeader."Prepared by") then begin
            SalesCommentLine.Reset();
            SalesCommentLine.SetRange("No.", FormHeader."No.");
            SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::"Equipment Hand Over");
            if SalesCommentLine.FindLast() then
                RejectComment := SalesCommentLine.Comment;

            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>HandOver Request No. ' + FormHeader."No." + ' has been Rejected by ' + UserId + ' because "' + RejectComment + '"';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := FormHeader."No.";
            EmailSubject := 'HandOver Request ' + DocumentNo + ' has been Rejected.';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure FormHeaderDelegate(var FormHeader: Record "Form Header")
    var
        Txt002: Label 'Are you sure you want to Delegate this document ?';
        CustomPurchFunction: Codeunit "Fleet Management";
    begin
        if Confirm(Txt002, true) then begin
            CustomPurchFunction.DelegatePurchaseApprovalRequestFM(FormHeader);
            FormHeader.SendRequisitionApprovedEmail(FormHeader);
        end;
    end;

    procedure FormHeaderReject(var FormHeader: Record "Form Header")
    var
        FormHeader1: Record "Form Header";
        ApprovalComments: Record "Sales Comment Line";
        ApprovalComments2: Record "Sales Comment Line";
        approvalComment: Page "Sales Comment Sheet";
        CustomPurchFunction: Codeunit "Fleet Management";
        customFunction: Codeunit "Fleet Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if Confirm('Are you sure you want to Reject this Requisition ?', true) then begin
            //Checking for comments before rejecting
            ApprovalComments.Reset();
            ApprovalComments.SetRange(ApprovalComments."No.", FormHeader."No.");
            ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Equipment Hand Over");
            if ApprovalComments.FindFirst() then begin
                ApprovalsMgmt.RejectRecordApprovalRequest(FormHeader.RecordId);
                customFunction.RejectApprovalRequestFM(FormHeader);
                FormHeader.SendRejectEmail(FormHeader);
            end else begin
                ApprovalComments2.Reset();
                ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"Equipment Hand Over");
                ApprovalComments2.SetRange(ApprovalComments2."No.", FormHeader."No.");
                ApprovalComments2.SetRange("Document Line No.", 0);
                approvalComment.SetTableView(ApprovalComments2);
                approvalComment.Run();
            end;
        end;
    end;

    procedure FormHeaderApprove(var FormHeader: Record "Form Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ClaimCount: Integer;
        Txt001: Label 'Are you sure you want to Approve this document ?';
        Txt002: Label 'Please make Sure you have at least one line in the Requisition Lines';
        UserSetup: Record "User Setup";
        ApprovalDoc: Codeunit "Fleet Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        customFunction: Codeunit "Fleet Management";
    begin
        if FormHeader.Status = FormHeader.Status::Released then
            Error('This document is already released');
        if FormHeader.Status = FormHeader.Status::Open then
            Error('Document Status must be set to Pending Approval');

        if Confirm(Txt001, true) then begin
            ClaimCount := 0;
            ApprovalEntry.Reset();
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", FormHeader."No.");
            ApprovalEntry.SetRange(ApprovalEntry."Approval Type", ApprovalEntry."Approval Type"::Approver);
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst() then begin
                ApprovalsMgmt.ApproveRecordApprovalRequest(FormHeader.RecordId);
            end
            else begin
                ApprovalsMgmt.ApproveRecordApprovalRequest(FormHeader.RecordId);
                FormHeader.ReleaseTheApprovedDoc();
            end;
            //Send email implemented
            customFunction.OpenApprovalEntriesFM(FormHeader);
            FormHeader.CheckDocumentRelease(FormHeader);
            FormHeader.SendRequisitionApprovedEmail(FormHeader);
        end;
    end;

    procedure AssignDriver()
    var
        FixedAssets: Record "Fixed Asset";
        HandOverHeader: Record "Form Header";
    begin
        Rec.TestField(Status, Rec.Status::Released);
        FixedAssets.Reset();
        FixedAssets.SetRange("No.", Rec."Equipment No.");
        if FixedAssets.FindFirst() then begin
            if FixedAssets."Responsible Employee" <> Rec."Former Driver" then
                Error('Equipment: %1 is currently Assigned to %2 not %3', Rec."Equipment No.", FixedAssets."Responsible Employee", rec."Former Driver");

            FixedAssets."Responsible Employee" := Rec."Assigned Driver";
            FixedAssets.Modify();

            //
            HandOverHeader.Reset();
            HandOverHeader.SetRange("Document Type", HandOverHeader."Document Type"::"Equipment Hand Over");
            HandOverHeader.SetRange("No.", Rec."No.");
            if HandOverHeader.FindFirst() then begin
                HandOverHeader."Driver Assigned" := true;
                HandOverHeader."Assignment Date" := Today;
                HandOverHeader."Assigned By" := UserId;
                HandOverHeader.Modify();
            end;

            Message('Driver: %1-%2 has been Assigned to Equipment: %3-%4 successfully.', Rec."Assigned Driver", Rec."Assigned Driver Name", Rec."Equipment No.", Rec."Equipment Name");
        end;
    end;

    procedure StartJourney()
    var
        FormHeader: Record "Form Header";
        Equipment: Record "Fixed Asset";
    begin
        Rec.TestField("Journey Started", false);

        FormHeader.Reset();
        FormHeader.SetRange("No.", Rec."No.");
        if FormHeader.FindFirst() then begin
            FormHeader."Journey Started" := true;
            FormHeader.Modify();

            Equipment.Reset();
            Equipment.SetRange("No.", Rec."Equipment No.");
            if Equipment.FindFirst() then begin
                Equipment."Equipment Status" := Equipment."Equipment Status"::"In Use";
                Equipment.Modify();
            end;
        end;

        Message('The Journey has started successfully');
    end;
    //Ending Journey
    procedure EndJourney()
    var
        FormHeader: Record "Form Header";
        Equipment: Record "Fixed Asset";
        //new code
        PerformanceHeader: Record "Performance Header";
        PerformanceLine: Record "Performance Line";
    begin
        Rec.TestField("Journey Started", true);
        Rec.TestField("Journey Ended", false);

        FormHeader.Reset();
        FormHeader.SetRange("No.", Rec."No.");
        if FormHeader.FindFirst() then begin
            FormHeader."Journey Ended" := true;
            FormHeader.Modify();

            Equipment.Reset();
            Equipment.SetRange("No.", Rec."Equipment No.");
            if Equipment.FindFirst() then begin
                Equipment."Equipment Status" := Equipment."Equipment Status"::Available;
                Equipment.Modify();
            end;
        end;

        // Count Jobs Executed by Driver
        FormHeader.Reset();
        FormHeader.SetRange("Document Type", FormHeader."Document Type"::"Journey Management Plan");
        FormHeader.SetRange("JMP User No.", Rec."JMP User No.");
        FormHeader.SetRange(Status, FormHeader.Status::Released);
        JobExecutedCount := FormHeader.Count();

        //new code
        // Post Distance to Performance Monitoring
        
        PerformanceHeader.Reset();
        PerformanceHeader.SetRange("Driver No.", Rec."JMP User No.");
        PerformanceHeader.SetRange("Document Type", PerformanceHeader."Document Type"::"Performance Monitoring");
       
        if PerformanceHeader.FindFirst() then begin
            PerformanceLine.Reset();
            PerformanceLine.SetRange("Document Type", PerformanceLine."Document Type"::"Performance Monitoring");
            PerformanceLine.SetRange("Document No.", PerformanceHeader."No.");
            PerformanceLine.SetRange("Employee No.", Rec."JMP User No.");
             
            
            if PerformanceLine.FindLast() then begin
                PerformanceLine.Date := Rec."From Date";
                PerformanceLine."KM Covered" += Rec.Distance;
                PerformanceLine."Days Worked" += Rec.Days;
                PerformanceLine."Hours Worked"+= Rec.Hours;
                JobExecutedCount += 1;
                PerformanceLine."Jobs Executed" := JobExecutedCount;
               
                PerformanceLine.Modify();
            end else begin
                // If no line exists, create one (optional, based on your setup)
                PerformanceLine.Init();
                PerformanceLine."Document Type" := PerformanceLine."Document Type"::"Performance Monitoring";
                PerformanceLine."Document No." := PerformanceHeader."No.";
                PerformanceLine."Line No." := 10000;  // Or calculate next line no
                PerformanceLine."Employee No." := Rec."JMP User No.";
                PerformanceLine."KM Covered" := Rec.Distance;
                PerformanceLine."Days Worked" += Rec.Days;
                PerformanceLine."Hours Worked"+= Rec.Hours;
                JobExecutedCount += 1;
                PerformanceLine."Jobs Executed" := JobExecutedCount;
                PerformanceLine.Insert();
            end;
        end;


        Message('Vehicle Journey has ended successfully and PMF updated');
    end;

    procedure PostIncident()
    var
    FormHeader: Record "Form Header";
    PerformanceLine: Record "Performance Line";
    PerformanceHeader: Record "Performance Header";
    IncidenceCount: Integer;
    begin
        //cross check to make sure its not posted 
    Rec.TestField("Incident Posted", false);
    // Count the total number of "Incident Notification Form" documents for the driver
    FormHeader.Reset();
    FormHeader.SetRange("Document Type", FormHeader."Document Type"::"Incident Notification Form");
    FormHeader.SetRange("Driver No.", Rec."Driver No.");
    IncidenceCount := FormHeader.Count();
    "Incident Posted" := true;

    //if Rec."Client Complaints"=''
           

    // Find the Performance Header for the driver
    PerformanceHeader.Reset();
    PerformanceHeader.SetRange("Driver No.", Rec."Driver No.");
    PerformanceHeader.SetRange("Document Type", PerformanceHeader."Document Type"::"Performance Monitoring");
    if PerformanceHeader.FindFirst() then begin
        // Find the corresponding Performance Line
        PerformanceLine.Reset();
        PerformanceLine.SetRange("Document Type", PerformanceLine."Document Type"::"Performance Monitoring");
        PerformanceLine.SetRange("Document No.", PerformanceHeader."No.");
        PerformanceLine.SetRange("Employee No.", Rec."Driver No.");
        if PerformanceLine.FindLast() then begin
            // Update the "Incidents Caused" field with the total count
            PerformanceLine."Incidents Caused" := IncidenceCount;
            PerformanceLine."No. Of Client Complaints" += 1;
            PerformanceLine.Modify();
            Message('Incident posted successfully. Total Incidents caused by the driver %1 is %2', Rec."Driver No.", IncidenceCount);
        end else begin
            // Optional: If no Performance Line exists, create one (uncomment if needed)
            PerformanceLine.Init();
            PerformanceLine."Document Type" := PerformanceLine."Document Type"::"Performance Monitoring";
            PerformanceLine."Document No." := PerformanceHeader."No.";
            PerformanceLine."Line No." := 10000;  // Calculate next line no if necessary
            PerformanceLine."Employee No." := Rec."Driver No.";
            //PerformanceLine."Incidents Caused" +=1;
            PerformanceLine."Incidents Caused" := IncidenceCount;
            PerformanceLine."No. Of Client Complaints" += 1;
            PerformanceLine.Insert();
            Message('Incident posted successfully. Total Incidents caused by the driver %1 is %2', Rec."Driver No.", IncidenceCount);
        end;
        end else begin
            Message('No Performance Monitoring document found for driver %1.', Rec."Driver No.");
        end;
    end;

    procedure PostClientComplaint()
    var
        FormHeader: Record "Form Header";
        PerformanceLine: Record "Performance Line";
        PerformanceHeader: Record "Performance Header";
        ComplaintCount: Integer;
    begin
        //
        Rec.TestField("Complaint Posted", false);
        // Count the total number of client complaints for the driver
        FormHeader.Reset();
        FormHeader.SetRange("Document Type", FormHeader."Document Type"::"Incident Notification Form");
        FormHeader.SetRange("Driver No.", Rec."Driver No.");
        FormHeader.SetRange("Complaint No.", Rec."Complaint No.");
        ComplaintCount := FormHeader.Count();
        "Complaint Posted" := true;

        // Find the Performance Header for the driver
        PerformanceHeader.Reset();
        PerformanceHeader.SetRange("Driver No.", Rec."Driver No.");
        PerformanceHeader.SetRange("Document Type", PerformanceHeader."Document Type"::"Performance Monitoring");
        if PerformanceHeader.FindLast() then begin
            // Find the corresponding Performance Line
            PerformanceLine.Reset();
            PerformanceLine.SetRange("Document Type", PerformanceLine."Document Type"::"Performance Monitoring");
            PerformanceLine.SetRange("Document No.", PerformanceHeader."No.");
            PerformanceLine.SetRange("Employee No.", Rec."Driver No.");
            if PerformanceLine.FindLast() then begin
                // Update the "No. Of Client Complaints" field with the total count
                PerformanceLine."No. Of Client Complaints" := ComplaintCount;
                PerformanceLine.Modify();
                Message('Client complaint posted successfully. Total client complaints for driver %1 is %2', Rec."Driver No.", ComplaintCount);
            end else begin
                // Optional: If no Performance Line exists, create one (uncomment if needed)
                PerformanceLine.Init();
                PerformanceLine."Document Type" := PerformanceLine."Document Type"::"Performance Monitoring";
                PerformanceLine."Document No." := PerformanceHeader."No.";
                PerformanceLine."Line No." := 10000;  // Calculate next line no if necessary
                PerformanceLine."Employee No." := Rec."Driver No.";
                PerformanceLine."No. Of Client Complaints" := ComplaintCount;
                PerformanceLine.Insert();
                Message('Client complaint posted successfully. Total client complaints for driver %1 is %2', Rec."Driver No.", ComplaintCount);
            end;
        end else begin
            Message('No Performance Monitoring document found for driver %1.', Rec."Driver No.");
        end;
        

    end;


    local procedure CopyFromStandardText()
    var
        StandardText: Record "Standard Text";
    begin
        StandardText.Get();
        Description := StandardText.Description;
    end;

    local procedure CopyFromGLAccount()
    var
        IsHandled: Boolean;
        GLAcc: Record "G/L Account";
    begin
        GLAcc.Get("Line To Invoice No.");
        GLAcc.TestField("Direct Posting", true);
        Description := GLAcc.Name;
    end;

    local procedure CopyFromItem()
    var
        Item: Record Item;
    begin
        if Item.Get(Rec."Line To Invoice No.") then begin
            Item.TestField(Blocked, false);
            Description := Item.Description;
            "Unit of Measure Code" := Item."Base Unit of Measure";
        end;
    end;

    procedure GetResource(): Record Resource
    var
        Resource: Record Resource;
    begin
        TestField("Line To Invoice No.");
        Resource.Get("Line To Invoice No.");
        exit(Resource);
    end;

    local procedure GetResource(var Resource: Record Resource)
    begin
        TestField("Line To Invoice No.");
        Resource.Get("Line To Invoice No.")
    end;

    local procedure CopyFromResource()
    var
        Resource: Record Resource;
    begin
        GetResource(Resource);
        Resource.CheckResourcePrivacyBlocked(false);
        Resource.TestField(Blocked, false);
        Resource.TestField("Gen. Prod. Posting Group");
        Description := Resource.Name;
        "Unit of Measure Code" := Resource."Base Unit of Measure";
    end;

    local procedure CopyFromFixedAsset()
    var
        FixedAsset: Record "Fixed Asset";
    begin
        FixedAsset.Get("Line To Invoice No.");
        FixedAsset.TestField(Blocked, false);
        Description := FixedAsset.Description;
    end;

    procedure CreateSalesInvoice(DocumentType: Enum "Sales Document Type")
    var
        SalesHeader: Record "Sales Header";
        SalesLines: Record "Sales Line";
        SalesLines1: Record "Sales Line";
        NextDocNo: Code[30];
        SalesReceivables: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        SalesOrderNo: Code[50];
        LineNo: Integer;
        SalesHeader1: Record "Sales Header";
        SalesHeader2: Record "Sales Header";
        SalesOrder: Page "Sales Order";
        SalesInvoice: Page "Sales Invoice";
        Resource: Record Resource;
        FormHeader: Record "Form Header";
        Message: Text;
    begin
        Rec.TestField("Client No.");
        Rec.TestField("Line To Invoice Type");
        Rec.TestField("Line To Invoice No.");
        Rec.TestField("Hire Rate");
        Rec.TestField("Posting Date");
        Rec.TestField("Unit of Measure Code");
        SalesReceivables.Get();

        Customer.Get(Rec."Client No.");

        if DocumentType = DocumentType::Order then
            NextDocNo := NoSeriesMgt.GetNextNo(SalesReceivables."Order Nos.", Rec."Posting Date", true)
        else if DocumentType = DocumentType::Invoice then
            NextDocNo := NoSeriesMgt.GetNextNo(SalesReceivables."Invoice Nos.", Rec."Posting Date", true);

        SalesHeader.Init();
        SalesHeader."No." := NextDocNo;
        SalesHeader."Document Type" := DocumentType;

        SalesHeader."Sell-to Customer No." := Rec."Client No.";
        SalesHeader."No. Printed" := 0;
        SalesHeader."Equipment Hire No." := "No.";
        SalesHeader."Equipment Type" := Rec."Equipment Type";
        SalesHeader."Equipment Hire Invoice" := true;
        SalesHeader."Hire Request No." := Rec."No.";
        SalesHeader.Status := SalesHeader.Status::Open;
        SalesHeader."Order Date" := Rec."Posting Date";
        SalesHeader."Posting Date" := Rec."Posting Date";
        SalesHeader."Document Date" := Rec."Posting Date";

        SalesHeader.InitRecord;
        SalesOrderNo := SalesHeader."No.";
        SalesHeader.VALIDATE("Posting Description", Rec."Client Name" + ' on ' + Format(Rec."Posting Date"));

        IF Rec."Posting Date" <> 0D THEN
            SalesHeader."Posting Date" := "Posting Date";
        SalesHeader."Document Date" := Rec."Posting Date";
        SalesHeader."Currency Code" := Rec.Currency;
        SalesHeader.INSERT(TRUE);

        SalesHeader.VALIDATE(SalesHeader."Sell-to Customer No.");
        SalesHeader.VALIDATE("Currency Code", Rec.Currency);
        SalesHeader.MODIFY;

        LineNo := 11000;

        SalesLines.INIT;
        SalesLines."Document Type" := DocumentType;
        SalesLines."Document No." := NextDocNo;
        SalesLines."Line No." := LineNo;
        SalesLines.VALIDATE("Sell-to Customer No.", Rec."Client No.");
        SalesLines.Type := Rec."Line To Invoice Type";
        SalesLines.VALIDATE("No.", Rec."Line To Invoice No.");
        //SalesLines."Description 2" := Rec.Description;
        SalesLines."Description 2" := 'Invoice for vehicle hire';
        SalesLines.VALIDATE("Currency Code", Rec.Currency);
        SalesLines.VALIDATE(Quantity, Rec.Quantity);
        SalesLines.validate("Unit of Measure", Rec."Unit of Measure Code");
        // SalesLines.validate("Unit Price", Rec."Hire Rate");
        SalesLines.validate("Unit Price", Rec."EstimatedHireCost");
        SalesLines.Description := Rec.Description;
        SalesLines.INSERT(TRUE);

        FormHeader.Reset();
        FormHeader.SetRange("No.", Rec."No.");
        if FormHeader.FindFirst() then begin
            FormHeader.Converted := true;
            FormHeader."Sales Invoice/Order No." := SalesOrderNo;
            FormHeader.Modify();
        end;

        //update the status
        SalesHeader1.GET(DocumentType, SalesOrderNo);
        SalesHeader1.Status := SalesHeader1.Status::Released;
        SalesHeader1.MODIFY;

        Message := 'Hire Request No: ' + Rec."No." + ' has been converted to sales ' + Format(DocumentType) + ' No: ' + SalesOrderNo + ' Would you like to Open it?';
        if Confirm(Message, true) then begin
            SalesHeader2.SetRange("Document Type", DocumentType);
            SalesHeader2.SetRange("No.", SalesOrderNo);

            if DocumentType = DocumentType::Order then
                PAGE.Run(Page::"Sales Order", SalesHeader2)
            else if DocumentType = DocumentType::Invoice then
                Page.Run(Page::"Sales Invoice", SalesHeader2);
        end;
    end;

    procedure GenerateSections()
    var
        FormLines: Record "Form Line";
    begin
        Rec.TestField("Document Type", Rec."Document Type"::"Equipment Inspection");
        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10000;
        FormLines.Sections := FormLines.Sections::"Walk around";
        FormLines.Description := 'Lights, signals';
        FormLines.Details := 'functioning, no wiring problems';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10001;
        FormLines.Sections := FormLines.Sections::"Walk around";
        FormLines.Description := 'Tire pressure, condition';
        FormLines.Details := 'Inspect ,wear, cuts';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10002;
        FormLines.Sections := FormLines.Sections::"Walk around";
        FormLines.Description := 'wheel nuts';
        FormLines.Details := 'loose ,missing';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10003;
        FormLines.Sections := FormLines.Sections::"Walk around";
        FormLines.Description := 'Windshield';
        FormLines.Details := 'Cracks, abrasions';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10004;
        FormLines.Sections := FormLines.Sections::"Walk around";
        FormLines.Description := 'Wipers / washers';
        FormLines.Details := 'Work ,and clear';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10005;
        FormLines.Sections := FormLines.Sections::"Walk around";
        FormLines.Description := 'Doors';
        FormLines.Details := 'Locks,handles,glass,mirrors';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10006;
        FormLines.Sections := FormLines.Sections::"Walk around";
        FormLines.Description := 'Cleanliness for use';
        FormLines.Details := 'Interior and outer cleanliness';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10007;
        FormLines.Sections := FormLines.Sections::"Walk around";
        FormLines.Description := 'Mud flaps';
        FormLines.Details := 'Loose,torn,missing';
        FormLines.Insert();


        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10008;
        FormLines.Sections := FormLines.Sections::"Walk around";
        FormLines.Description := 'Accident damage';
        FormLines.Details := 'Check and report';
        FormLines.Insert();

        //Under Bonnet
        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10009;
        FormLines.Sections := FormLines.Sections::"Under Bonnet";
        FormLines.Description := 'Leaks, General';
        FormLines.Details := 'Inspect';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10010;
        FormLines.Sections := FormLines.Sections::"Under Bonnet";
        FormLines.Description := 'Radiator';
        FormLines.Details := 'Fluid level and leaks';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10011;
        FormLines.Sections := FormLines.Sections::"Under Bonnet";
        FormLines.Description := 'Belts, hoses';
        FormLines.Details := 'Torn, leaking';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10012;
        FormLines.Sections := FormLines.Sections::"Under Bonnet";
        FormLines.Description := 'Engine oil';
        FormLines.Details := 'Check dip stick level';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10013;
        FormLines.Sections := FormLines.Sections::"Under Bonnet";
        FormLines.Description := 'Fluid levels';
        FormLines.Details := 'Check';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10014;
        FormLines.Sections := FormLines.Sections::"Under Bonnet";
        FormLines.Description := 'Battery';
        FormLines.Details := 'Clamp, terminals Secure';
        FormLines.Insert();

        //Inside Vehicle
        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10015;
        FormLines.Sections := FormLines.Sections::"Inside Vehicle";
        FormLines.Description := 'Interior';
        FormLines.Details := 'Check for faults / Damages';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10016;
        FormLines.Sections := FormLines.Sections::"Inside Vehicle";
        FormLines.Description := 'Seat belts';
        FormLines.Details := 'Operation / damage';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10017;
        FormLines.Sections := FormLines.Sections::"Inside Vehicle";
        FormLines.Description := 'Horn';
        FormLines.Details := 'Test';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10018;
        FormLines.Sections := FormLines.Sections::"Inside Vehicle";
        FormLines.Description := 'Gauges, instruments';
        FormLines.Details := 'Must function';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10019;
        FormLines.Sections := FormLines.Sections::"Inside Vehicle";
        FormLines.Description := 'Radio - Two way';
        FormLines.Details := 'Check operation';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10020;
        FormLines.Sections := FormLines.Sections::"Inside Vehicle";
        FormLines.Description := 'Reverse Alarm';
        FormLines.Details := 'Check operation';
        FormLines.Insert();

        //Emergency Equipment
        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10021;
        FormLines.Sections := FormLines.Sections::"Emergency Equipment";
        FormLines.Description := 'Fire extinguisher';
        FormLines.Details := 'Full , secure';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10022;
        FormLines.Sections := FormLines.Sections::"Emergency Equipment";
        FormLines.Description := 'First aid kit';
        FormLines.Details := 'Full ,secure';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10023;
        FormLines.Sections := FormLines.Sections::"Emergency Equipment";
        FormLines.Description := 'Tow rope & Shackle';
        FormLines.Details := 'Inspect ,wear, cuts';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10024;
        FormLines.Sections := FormLines.Sections::"Emergency Equipment";
        FormLines.Description := 'Spare Wheel';
        FormLines.Details := 'pressure , wear condition';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10025;
        FormLines.Sections := FormLines.Sections::"Emergency Equipment";
        FormLines.Description := 'Reflector triangles';
        FormLines.Details := 'Available, 2 pieces';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10026;
        FormLines.Sections := FormLines.Sections::"Emergency Equipment";
        FormLines.Description := 'Jack, Handle, Wheel spanner, jacking plate ';
        FormLines.Details := 'Check';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10027;
        FormLines.Sections := FormLines.Sections::"Emergency Equipment";
        FormLines.Description := 'Shovel';
        FormLines.Details := 'Good condition';
        FormLines.Insert();

        //Before Setting Off
        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10028;
        FormLines.Sections := FormLines.Sections::"Before setting off";
        FormLines.Description := 'Brakes';
        FormLines.Details := 'Test before leaving';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10029;
        FormLines.Sections := FormLines.Sections::"Before setting off";
        FormLines.Description := 'Clutch';
        FormLines.Details := 'Working, free play';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10030;
        FormLines.Sections := FormLines.Sections::"Before setting off";
        FormLines.Description := 'Steering';
        FormLines.Details := 'Free travel';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10031;
        FormLines.Sections := FormLines.Sections::"Before setting off";
        FormLines.Description := 'Unusual noises';
        FormLines.Details := 'Report to workshop';
        FormLines.Insert();

        Clear(FormLines);
        FormLines.Init();
        FormLines."Document Type" := FormLines."Document Type"::"Equipment Inspection";
        FormLines."Document No." := Rec."No.";
        FormLines."Line No." := 10032;
        FormLines.Sections := FormLines.Sections::"Before setting off";
        FormLines.Description := '4 X 4 system';
        FormLines.Details := 'Test';
        FormLines.Insert();
    end;

    

    procedure SetOut()
    var
        FormLines: Record "Form Line";
        Equipment: Record "Fixed Asset";
        FormHeader: Record "Form Header";
    begin
        Rec.TestField("Set out", false);
        if Rec."Document Type" = Rec."Document Type"::"External Hire" then
            Rec.TestField(Status, Rec.Status::Released);
        if Rec."Document Type" = Rec."Document Type"::"Internal Hire" then
            Rec.TestField(Authorized, true);

        FormLines.Reset();
        FormLines.SetRange("Document Type", Rec."Document Type");
        FormLines.SetRange("Document No.", Rec."No.");
        if FormLines.FindFirst() then begin
            repeat
                //set equipment status to in use
                Equipment.Get(FormLines."Equipment No.");
                Equipment."Equipment Status" := Equipment."Equipment Status"::"In Use";
                Equipment.Modify();
            until FormLines.Next() = 0;
        end;

        FormHeader.Reset();
        FormHeader.SetRange("No.", Rec."No.");
        if FormHeader.FindFirst() then begin
            FormHeader."Set out" := true;
            FormHeader."Journey Started" := true;
            FormHeader."Set out Date" := Today;
            FormHeader."Set out By" := UserId;
            FormHeader.Modify();
        end;

        Message('Equipment(s) have been set out successfully');
    end;

    procedure touchDown()
    var
        FormLines: Record "Form Line";
        Equipment: Record "Fixed Asset";
        FormHeader: Record "Form Header";
    begin
        Rec.TestField("Set out", true);
        Rec.TestField("Journey Started", true);
        Rec.TestField("Touch Down", false);

        if Rec."Document Type" = Rec."Document Type"::"External Hire" then
            Rec.TestField(Status, Rec.Status::Released);
        if Rec."Document Type" = Rec."Document Type"::"Internal Hire" then
            Rec.TestField(Authorized, true);

        FormLines.Reset();
        FormLines.SetRange("Document Type", Rec."Document Type");
        FormLines.SetRange("Document No.", Rec."No.");
        if FormLines.FindFirst() then begin
            repeat
                //set equipment status to in use
                Equipment.Get(FormLines."Equipment No.");
                Equipment."Equipment Status" := Equipment."Equipment Status"::Available;
                Equipment.Modify();
            until FormLines.Next() = 0;
        end;

        FormHeader.Reset();
        FormHeader.SetRange("No.", Rec."No.");
        if FormHeader.FindFirst() then begin
            FormHeader."Touch Down" := true;
            FormHeader."Touch Down Date" := Today;
            FormHeader."Touch Down By" := UserId;
            FormHeader.Modify();
        end;

        Message('Equipment(s) have been returned successfully');
    end;

    
}