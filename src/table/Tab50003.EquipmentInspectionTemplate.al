table 50003 "Equipment Inspection Template"
{
    Caption = 'Equipment Inspection Template';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            trigger OnValidate()
            var
                Setup: Record "Fleet Management Setup";
                NoSeries: Codeunit "No. Series";
            begin
                if "Code" <> xRec."Code" then begin
                    Setup.Get();
                    Setup.TestField("Template Nos");
                    NoSeries.TestManual(Setup."Template Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Template Code"; Code[20])
        {
            Caption = 'Inspection Template Code';
        }

        field(3; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(4; Sections; Enum "Inspection Type")
        {
            Caption = 'Section';
        }

        field(5; Description; Text[250])
        {
            Caption = 'Description';
        }

        field(6; Details; Text[250])
        {
            Caption = 'Details';
        }

        field(7; "Active"; Boolean)
        {
            Caption = 'Active';
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series".Code;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(LineNo; "Line No")
        {
           
        }
    }

    trigger OnInsert()
    var
     Setup: Record "Fleet Management Setup";
     "NoSeries": Codeunit "No. Series";
    begin
        if "Code" = '' then begin
            Setup.Get();
            Setup.TestField("Template Nos");
            "No. Series" := Setup."Template Nos";
            "Code" := NoSeries.GetNextNo("No. Series");
        end;

    end;

    procedure CreateInspectionTemplate()
    var
        FormLines: Record "Form Line";
    begin
        //Electrical
    AddTemplateLine(10000, FormLines.Sections::Electrical, 'Battery condition', 'functioning, no wiring problems');
    AddTemplateLine(10001, FormLines.Sections::"Electrical", 'Battery terminal', 'Inspect, wear, cuts');
    AddTemplateLine(10002, FormLines.Sections::Electrical, 'Alternately', 'Loose, missing');
    AddTemplateLine(10003, FormLines.Sections::Electrical, 'Starter', 'Cracks, abrasions');
    AddTemplateLine(10004, FormLines.Sections::Electrical, 'AVR', 'Work, and clear');
    AddTemplateLine(10005, FormLines.Sections::Electrical, 'Output voltage', 'Locks, handles, glass, mirrors');
    AddTemplateLine(10006, FormLines.Sections::Electrical, 'Frequency', 'Interior and outer cleanliness');
    AddTemplateLine(10007, FormLines.Sections::Electrical, 'Circuit breaker', 'Loose, torn, missing');
    AddTemplateLine(10008, FormLines.Sections::Electrical, 'Earthly', 'Check and report');

    // Lubrication
    AddTemplateLine(10009, FormLines.Sections::Lubrication, 'Grease points', 'Inspect');
    AddTemplateLine(10010, FormLines.Sections::Lubrication, 'Bearing condition', 'Fluid level and leaks');

    //Mechanical
    AddTemplateLine(10011, FormLines.Sections::Mechanical, 'Vibration', 'Torn, leaking');
    AddTemplateLine(10012, FormLines.Sections::Mechanical, 'Noise', 'Check dip stick level');
    AddTemplateLine(10013, FormLines.Sections::Mechanical, 'Coupling', 'Check');
    AddTemplateLine(10014, FormLines.Sections::Mechanical, 'Base frame', 'Clamp, terminals secure');
    AddTemplateLine(10015, FormLines.Sections::Mechanical, 'Anti-vibration mounts', 'Check for faults / damages');
    AddTemplateLine(10016, FormLines.Sections::Mechanical, 'Others', 'Operation / damage');

    // Inside Vehicle
    AddTemplateLine(10017, FormLines.Sections::Housekeeping, 'Cleanliness', 'Test');
    AddTemplateLine(10018, FormLines.Sections::Housekeeping, 'Ventilation', 'Must function');
    AddTemplateLine(10019, FormLines.Sections::Housekeeping, 'Fire extinguisher', 'Check operation');
    AddTemplateLine(10020, FormLines.Sections::Housekeeping, 'Documentation', 'Check operation');

    AddTemplateLine(10021, FormLines.Sections::General, 'Hour meter', 'Test before leaving');
    AddTemplateLine(10022, FormLines.Sections::General, 'Control panel', 'Working, free play');
    AddTemplateLine(10023, FormLines.Sections::General, 'Warning lamps', 'Free travel');
    AddTemplateLine(10024, FormLines.Sections::General, 'Emergency stop', 'Report to workshop');
    AddTemplateLine(10025, FormLines.Sections::General, 'Battery charger', 'Test');

    AddTemplateLine(10026, FormLines.Sections::Engine, 'Engine oil level', '');
    AddTemplateLine(10027, FormLines.Sections::Engine, 'Engine oil condition', '');
    AddTemplateLine(10028, FormLines.Sections::Engine, 'Oil leaks', '');
    AddTemplateLine(10029, FormLines.Sections::Engine, 'Coolant level', '');
    AddTemplateLine(10030, FormLines.Sections::Engine, 'Coolant condition', '');
    AddTemplateLine(10031, FormLines.Sections::Engine, 'Radiator', '');
    AddTemplateLine(10032, FormLines.Sections::Engine, 'Fan belt', '');
    AddTemplateLine(10033, FormLines.Sections::Engine, 'Air filter', '');
    AddTemplateLine(10034, FormLines.Sections::Engine, 'Fuel filter', '');
    AddTemplateLine(10035, FormLines.Sections::Engine, 'Oil filter', '');
    AddTemplateLine(10036, FormLines.Sections::Engine, 'Hoses', '');
    AddTemplateLine(10037, FormLines.Sections::Engine, 'Exhaust system', '');
    AddTemplateLine(10038, FormLines.Sections::Engine, 'Engine mounts', '');

    AddTemplateLine(10039, FormLines.Sections::Fuel, 'Fuel tank', '');
    AddTemplateLine(10040, FormLines.Sections::Fuel, 'Fuel lines', '');
    AddTemplateLine(10041, FormLines.Sections::Fuel, 'Water separator', '');
    AddTemplateLine(10042, FormLines.Sections::Fuel, 'Fuel leaks', '');

        // AddTemplateLine(10000, FormLines.Sections::"Walk around", 'Lights, signals', 'Functioning, no wiring problems');
        // AddTemplateLine(10001, FormLines.Sections::"Walk around", 'Tire pressure, condition', 'Inspect, wear, cuts');
        // AddTemplateLine(10002, FormLines.Sections::"Walk around", 'Wheel nuts', 'Loose, missing');
        // AddTemplateLine(10003, FormLines.Sections::"Walk around", 'Windshield', 'Cracks, abrasions');
        // AddTemplateLine(10004, FormLines.Sections::"Walk around", 'Wipers / washers', 'Work, and clear');
        // AddTemplateLine(10005, FormLines.Sections::"Walk around", 'Doors', 'Locks, handles, glass, mirrors');
        // AddTemplateLine(10006, FormLines.Sections::"Walk around", 'Cleanliness for use', 'Interior and outer cleanliness');
        // AddTemplateLine(10007, FormLines.Sections::"Walk around", 'Mud flaps', 'Loose, torn, missing');
        // AddTemplateLine(10008, FormLines.Sections::"Walk around", 'Accident damage', 'Check and report');

        // AddTemplateLine(10009, FormLines.Sections::"Under Bonnet", 'Leaks, General', 'Inspect');
        // AddTemplateLine(10010, FormLines.Sections::"Under Bonnet", 'Radiator', 'Fluid level and leaks');
        // AddTemplateLine(10011, FormLines.Sections::"Under Bonnet", 'Belts, hoses', 'Torn, leaking');
        // AddTemplateLine(10012, FormLines.Sections::"Under Bonnet", 'Engine oil', 'Check dip stick level');
        // AddTemplateLine(10013, FormLines.Sections::"Under Bonnet", 'Fluid levels', 'Check');
        // AddTemplateLine(10014, FormLines.Sections::"Under Bonnet", 'Battery', 'Clamp, terminals secure');

        // AddTemplateLine(10015, FormLines.Sections::"Inside Vehicle", 'Interior', 'Check for faults / damages');
        // AddTemplateLine(10016, FormLines.Sections::"Inside Vehicle", 'Seat belts', 'Operation / damage');
        // AddTemplateLine(10017, FormLines.Sections::"Inside Vehicle", 'Horn', 'Test');
        // AddTemplateLine(10018, FormLines.Sections::"Inside Vehicle", 'Gauges, instruments', 'Must function');
        // AddTemplateLine(10019, FormLines.Sections::"Inside Vehicle", 'Radio - Two way', 'Check operation');
        // AddTemplateLine(10020, FormLines.Sections::"Inside Vehicle", 'Reverse Alarm', 'Check operation');

        // AddTemplateLine(10021, FormLines.Sections::"Emergency Equipment", 'Fire extinguisher', 'Full, secure');
        // AddTemplateLine(10022, FormLines.Sections::"Emergency Equipment", 'First aid kit', 'Full, secure');
        // AddTemplateLine(10023, FormLines.Sections::"Emergency Equipment", 'Tow rope & Shackle', 'Inspect, wear, cuts');
        // AddTemplateLine(10024, FormLines.Sections::"Emergency Equipment", 'Spare Wheel', 'Pressure, wear condition');
        // AddTemplateLine(10025, FormLines.Sections::"Emergency Equipment", 'Reflector triangles', 'Available, 2 pieces');
        // AddTemplateLine(10026, FormLines.Sections::"Emergency Equipment", 'Jack, Handle, Wheel spanner, jacking plate', 'Check');
        // AddTemplateLine(10027, FormLines.Sections::"Emergency Equipment", 'Shovel', 'Good condition');

        // AddTemplateLine(10028, FormLines.Sections::"Before setting off", 'Brakes', 'Test before leaving');
        // AddTemplateLine(10029, FormLines.Sections::"Before setting off", 'Clutch', 'Working, free play');
        // AddTemplateLine(10030, FormLines.Sections::"Before setting off", 'Steering', 'Free travel');
        // AddTemplateLine(10031, FormLines.Sections::"Before setting off", 'Unusual noises', 'Report to workshop');
        // AddTemplateLine(10032, FormLines.Sections::"Before setting off", '4 X 4 system', 'Test');
    end;
//failed will import directly
local procedure AddTemplateLine(
    LineNo: Integer;
    Section: Enum "Inspection Type";
    Description: Text[250];
    Details: Text[250])
var
    Template: Record "Equipment Inspection Template";
    Setup: Record "Fleet Management Setup";
     "NoSeries": Codeunit "No. Series";
begin
    Template.Init();
    Template.Code := NoSeries.GetNextNo("No. Series");
    Template."Template Code" := 'GENERATORS';
    Template."Line No" := LineNo;
    Template.Sections := Section;
    Template.Description := Description;
    Template.Details := Details;
    Template.Active := true;
    Template.Insert();
end;



}


