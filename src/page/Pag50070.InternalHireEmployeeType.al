page 50070 "Internal Hire Employee Type"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Incident Line";
    SourceTableView = WHERE("Document Type" = FILTER("Internal Hire"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Type field.', Comment = '%';
                }
            }
        }

    }
}