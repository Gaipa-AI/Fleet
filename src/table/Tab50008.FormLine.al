table 50008 "Form Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; enum "Form Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Items Present"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Present; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec.Present then
                    if Rec.Missing or Rec.Damaged then
                        Error('Only one option is allowed');
            end;
        }
        field(6; Missing; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec.Missing then
                    if Rec.Present or Rec.Damaged then
                        Error('Only one option is allowed');
            end;
        }
        field(7; Damaged; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec.Damaged then
                    if Rec.Missing or Rec.Present then
                        Error('Only one option is allowed');
            end;
        }
        field(8; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Equipment No."; Code[20])
        {
            
            TableRelation = "Fixed Asset"."No." where("Equipment Status" = const(Available));
            
                
            trigger OnValidate()
            var
                FixedAsset: Record "Fixed Asset";
            begin
                if FixedAsset.Get(Rec."Equipment No.") then begin

                    FixedAsset.TestField("Equipment Status", FixedAsset."Equipment Status"::Available);
                    FixedAsset.TestField("Equipment Type", FixedAsset."Equipment Type");
                    FixedAsset.TestField(Model);
                    FixedAsset.TestField(Make);
                    Rec."Equipment Make" := FixedAsset.Make;
                    Rec."Equipment Name" := FixedAsset.Description;
                    Rec."Equipment Serial No." := FixedAsset."Serial No.";
                    Rec."Equipment Model" := FixedAsset."Model";
                    Rec."Equipment RegNo" := FixedAsset."Registration No.";

                    Rec."Equipment Type" := FixedAsset."Equipment Type";
                    Rec."Vehicle/Equipment Location" := FixedAsset."FA Location Code";
                    Rec."Next Service Date" := FixedAsset."Next Service Date";
                    Rec."Current Mileage" := FixedAsset."Vehicle Mileage";
                    Rec."Next Service KM" := FixedAsset."Next Service At Mileage";
                    Rec."Service Date" := FixedAsset."Service Date";
                    Rec."Remaining Service Mileage" :=  "Next Service KM" - "Current Mileage";

                    
                    Rec.Validate("Driver No.", FixedAsset."Responsible Employee");

                    if Rec."Document Type" = Rec."Document Type"::"Routine Service Tracker" then begin
                        FixedAsset.TestField("Service Interval");
                        Rec.Validate("Service Interval", FixedAsset."Service Interval");
                    end;
                   
                end else begin
                    Rec."Equipment Make" := '';
                    Rec."Equipment Name" := '';
                    Rec."Equipment Serial No." := '';
                    Rec."Equipment Model" := '';
                    Rec."Equipment RegNo" := '';
                    Rec."Equipment Type" := '';
                    Rec.Validate("Driver Name", '');
                end;
                
            end;

        }

        
        field(10; "Equipment Make"; Text[50])
        {
            Editable = true;
        }
        field(11; "Driver No."; Code[20])
        {
            TableRelation = Employee."No." where("Employee Type" = filter('DRIVER'));
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get(Rec."Driver No.") then
                    Rec."Driver Name" := Employee.FullName()
                else
                    Rec."Driver Name" := '';

                // Rec.Modify();
            end;
        }
        field(12; "Driver Name"; Text[200])
        {
        }
        field(13; "Equipment Serial No."; Text[100])
        {
            Editable = true;
        }
        field(14; "Equipment Name"; Text[150])
        {
            Editable = false;
        }
        field(15; "Equipment Model"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Equipment RegNo"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));

            DataClassification = ToBeClassified;
        }
        field(18; "Client No."; Code[20])
        {
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get(Rec."Client No.") then begin
                    Rec."Client Name" := Customer.Name;
                    // Rec.Modify();
                end;
            end;
        }
        field(19; "Client Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Job Location"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Start Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Planned End Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Opening Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Closing Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; From; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Destination; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Fuel Top-up (Liters)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Sections; Enum "Inspection Type")
        {
            DataClassification = ToBeClassified;
        }
        field(30; Description; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(31; Details; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; Monday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; Tuesday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; Wednesday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; Thursday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(36; Friday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; Saturday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; Sunday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; Comment; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Service Date"; Date)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // begin
            //     if Rec."Service Date" <> 0D then begin
            //         Rec.Validate("Next Service Date", CalculateEndDate(Rec."Service Date", Rec."Service Interval"));
            //         Rec.Modify();
            //     end;
            // end;
        }
        field(41; "Vehicle/Equipment Location"; Code[20])
        {
            // TableRelation = "General value".Code where(Type = const(Location));
            TableRelation = "Fixed Asset"."FA Location Code";
        }
        field(42; "Service KM"; Decimal)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(43; "Service Hours"; Integer)
        {
            trigger OnValidate()
            begin
                if Rec."Service Hours" <> 0 then begin
                    Rec."Next Service Hours" := Rec."Service Hours" + Rec."Service Interval";
                    Rec.Modify();
                end;
            end;
        }
        field(44; "Details Of Service Done"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Next Service Date"; Date)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     FixedAsset: Record "Fixed Asset";
            // begin
            //     if Rec."Next Service Date" <> 0D then begin
            //         if Rec."Equipment No." <> '' then begin
            //             if FixedAsset.Get(Rec."Equipment No.") then begin
            //                 FixedAsset."Next Service Date" := Rec."Next Service Date";
            //                 FixedAsset.Modify();
            //             end;
            //         end;
            //     end;
            // end;
        }
        field(46; "Next Service KM"; Decimal)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     FixedAsset: Record "Fixed Asset";
            // begin
            //     if Rec."Next Service KM" <> 0 then begin
            //         if Rec."Equipment No." <> '' then begin
            //             if FixedAsset.Get(Rec."Equipment No.") then begin
            //                 FixedAsset."Next Service At Mileage" := Rec."Next Service KM";
            //                 FixedAsset.Modify();
            //             end;
            //         end;
            //     end;
            // end;
        }
        field(47; "Next Service Hours"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Service Interval"; Integer)
        {
            Editable = false;
        }
        field(49; "Current Mileage"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Remaining Service Mileage"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Date of Current Mileage"; Date)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //  FormHeader: Record "Form Header";
            // begin
            //     Rec."Date of Current Mileage" := FormHeader."Last Vehicle Inspection"

            // end;
        }


    }

    keys
    {
        key(Key1; "Document Type", Sections, "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    procedure EquipmentTypeFilter(): Text var Requisition: Record "Form Header";
    begin
        if Requisition.Get(Rec."Equipment No.")then begin
            exit(Requisition."Equipment Type");
        end;
    end;

    // ...existing code...

    procedure ListItems()
    var
        FormLines: Record "Form Line";
        LineNo: Integer;
        ItemsArray: array[9] of Text;
        i: Integer;
    begin
        Rec.TestField("Document Type", Rec."Document Type"::"Equipment Hand Over");
        
        // Delete existing lines first to avoid duplicates
        FormLines.Reset();
        FormLines.SetRange("Document Type", FormLines."Document Type"::"Equipment Hand Over");
        FormLines.SetRange("Document No.", Rec."Document No.");
        if FormLines.FindSet() then
            FormLines.DeleteAll();

        // Define items array
        ItemsArray[1] := 'SPARE TYRE';
        ItemsArray[2] := 'CAR MANUAL';
        ItemsArray[3] := 'JACK KIT';
        ItemsArray[4] := 'SPANNER';
        ItemsArray[5] := 'FIRE EXTINGUISHER';
        ItemsArray[6] := 'REFLECTOR TRIANGLES';
        ItemsArray[7] := 'FIRST AID KIT';
        ItemsArray[8] := 'TIRE LEVER';
        ItemsArray[9] := 'OTHERS';

        // Insert lines with incremental line numbers
        LineNo := 10000;
        for i := 1 to ArrayLen(ItemsArray) do begin
            Clear(FormLines);
            FormLines.Init();
            FormLines."Document Type" := FormLines."Document Type"::"Equipment Hand Over";
            FormLines."Document No." := Rec."Document No.";
            FormLines."Line No." := LineNo;
            FormLines."Items Present" := ItemsArray[i];
            FormLines.Description := ItemsArray[i];
            FormLines.Insert();
            LineNo += 10000;
        end;

        Message('Equipment hand-over items list created successfully.');
    end;

// ...existing code...

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure CalculateEndDate(StartDate: Date; HoursToAdd: Integer): Date
    var
        DaysToAdd: Integer;
    begin
        // Convert hours to days (rounding up if there's a remainder)
        DaysToAdd := HoursToAdd div 24;
        if (HoursToAdd mod 24) > 0 then
            DaysToAdd += 1;

        // Add days to StartDate
        exit(StartDate + DaysToAdd);
    end;
}