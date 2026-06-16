page 50043 "Performance Monitoring Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Performance Line";
    SourceTableView = WHERE("Document Type" = FILTER("Performance Monitoring"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.', Comment = '%';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                    Editable = false;
                }
                // field("Job Expectations"; Rec."Job Expectations")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Job Expectations field.', Comment = '%';
                // }
                field("Days Worked"; Rec."Days Worked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Days Worked field.', Comment = '%';
                    Editable = false;
                }
                
                field("Jobs Executed"; Rec."Jobs Executed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Jobs Executed field.', Comment = '%';
                    Editable = false;
                }
                field("KM Covered"; Rec."KM Covered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the KM Covered field.', Comment = '%';
                    Editable = false;
                }
                field("Hours Worked"; Rec."Hours Worked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hours Worked field.', Comment = '%';
                    Editable = false;
                }
                field("Incidents Caused"; Rec."Incidents Caused")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incidents Caused field.', Comment = '%';
                    DrillDownPageID = "Incident Form List" ;
                    //DrillDownPageView="Incident Form List";
                
                }
                field("No. Of Client Complaints"; Rec."No. Of Client Complaints")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Of Client Complaints field.', Comment = '%';
                    DrillDownPageID = "Client Complaint List" ;
                }
            }
        }
    }
}