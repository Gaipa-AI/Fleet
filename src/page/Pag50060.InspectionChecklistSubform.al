page 50060 "Inspection Checklist Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Form Line";
    SourceTableView = where("Document Type" = const("Equipment Inspection"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Details field.', Comment = '%';
                }
                
                field(Present; Rec.Present)
                {
                    Caption = 'Okay';
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is missing', Comment = '%';

                }
                field(Missing; Rec.Missing)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is missing', Comment = '%';

                }
                field(Damaged; Rec.Damaged)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that part of the vehicle is damaged', Comment = '%';

                }

                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
}